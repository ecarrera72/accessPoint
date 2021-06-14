const { connectiondb } = require('../../database/database');
const { isloggedIn } = require('../../lib/auth');
const Serialport = require('serialport');
const express = require('express');
const router = express.Router(); 

router.get('/', isloggedIn, async (req, res) => {
    let portList = await Serialport.list()
    let portPath = [];

    portList.forEach( e => {
        if ( e.pnpId != undefined ) { portPath.push( e.path ); }
    });

    console.log( portPath[0] );

    let serial = new Serialport( portPath[0], { baudRate: 9600 } );

    setTimeout( async () => {
        console.log( await serial.write( '@' ) );
    }, 3000)

    setInterval( async () => {
        let buf = await serial.read(16);

        if (buf != null) {
            console.log( buf.toString( 'ascii' ) );
        }

    }, 2000)

    // while ( true ) {

    //     console.log( serial.read(1) );
    // }

    // let data = await serial.read( 10 );

    // console.log( data );

    
    res.render('catalogs/highCard');
});

module.exports = router;