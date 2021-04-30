const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const crypto = require('crypto');
const { connectiondb } = require('../database/database');
//const helpers = require('../lib/helpers');
//const { getDataParams } = require('../service/api');

passport.use('local.signin', new localStrategy({
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, username, password, done) => {
    const encript = crypto.createHash('md5').update(password).digest('hex');
    let connect = await connectiondb();
    const response = await connect.query('SELECT * FROM user WHERE user = ? AND password = ?', [username, encript]);
    //const response = await getDataParams('user/auth', `${username}/${encript}`);
    
    if (response[0] !== undefined) {
        const user = response[0];
        done(null, user, req.flash('success', 'Bienvenido ' + user.name));
    } else {
        done(null, false, req.flash('message', 'Usuario y/o Contaseña Incorrecto.'));
    }
}));

// passport.use('local.signup', new localStrategy({
//     usernameField: 'username',
//     passwordField: 'password',
//     passReqToCallback: true
// }, async (req, username, password, done) => {
//     const { fullname } = req.body;
//     const newUser = {
//         username,
//         password,
//         fullname
//     };

//     newUser.password = await helpers.encryptPassword(password);
//     const result = await pool.query('INSERT INTO user SET ?', [newUser]);
//     newUser.id = result.insertId;
//     return done(null, newUser);
// }));

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser( async (id, done) => {
    let connect = await connectiondb();
    const response = await connect.query('SELECT * FROM user WHERE id = ?', [id]);
    done(null, response[0]);
});