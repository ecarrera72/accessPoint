const { connectiondb } = require('../../database/database');
const { isloggedIn } = require('../../lib/auth');
const strftime = require('strftime');
const express = require('express');
const clientFtp = require('basic-ftp');
const router = express.Router();

router.get('/', isloggedIn, async (req, res) => {
    res.render('reports/movements');
});

router.get('/details', isloggedIn, async (req, res) => {
    sql = `
        SELECT tlt.cat_dispositivo_rfid_id, cl.nombre_local as ubicacion, ci.description as inmueble, tlt.cat_tarjeta_id,
            ct.numero_tarjeta as numTarj, CONCAT(clo.nombre_locatario,' ',clo.apellidos_locatario) as nombre, 
            cl2.nombre_local as local, cp.nombre_puesto as puesto, tlt.cat_evento_tarjeta_id, cet.nombre_evento as evento,
            tlt.fecha_hora as fecha, tlt.imagen
        FROM tbl_log_tarjeta as tlt
        JOIN cat_dispositivo_rfid as cdr ON cdr.cat_dispositivo_rfid_id = tlt.cat_dispositivo_rfid_id
        JOIN cat_local as cl ON cl.cat_local_id = cdr.cat_local_id
        JOIN cat_inmueble as ci ON ci.id = cdr.cat_inmueble_id
        JOIN cat_tarjeta as ct ON ct.cat_tarjeta_id = tlt.cat_tarjeta_id
        JOIN cat_locatario as clo ON clo.cat_locatario_id = ct.cat_locatario_id
        JOIN cat_local as cl2 ON cl2.cat_local_id = clo.cat_local_id
        JOIN cat_puesto as cp ON cp.cat_puesto_id = clo.cat_puesto_id
        JOIN cat_evento_tarjeta as cet ON cet.cat_evento_tarjeta_id = tlt.cat_evento_tarjeta_id `
    
    if ( req.query.fromDate.includes('-') ) { 
        sql += `WHERE DATE(tlt.fecha_hora) >= '${ req.query.fromDate.split('-').reverse().join('-') }'`;
    }
    if ( req.query.toDate.includes('-') ) {
        sql.includes('WHERE') ? sql += ` AND `: sql += `WHERE `;
        sql += `DATE(tlt.fecha_hora) <= '${ req.query.toDate.split('-').reverse().join('-') }'`;
    }

    sql += ' ORDER BY tlt.tbl_log_rfid_id DESC ';

    let connection = await connectiondb();
    const response = await connection.query( sql );

    response.forEach( e => {
        e.fecha = strftime( '%d-%m-%Y %H:%M:%S', e.fecha );
    });

    res.json( response )
});

router.get('/image', isloggedIn, async (req, res) => { 
    const client = new clientFtp.Client();
    client.ftp.verbose = true;
    let image = null;
    try {
        await client.access({
            host: 'siereportes.dyndns.org',
            user: 'Asistencia',
            password: 'AztFTP#.2',
            port: 821,
            secure: false
        });

        image = await client.downloadTo( 'src/public/ftp/' + req.query.nameFile, req.query.nameFile );

    } catch ( err ) {
        console.error( err );
    }

    console.log( image );

    client.close();

    res.json( image );

});

module.exports = router;
