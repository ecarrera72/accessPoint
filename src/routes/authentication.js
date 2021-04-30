const { isloggedIn, isNotLoggedIn } = require('../lib/auth');
const { connectiondb } = require('../database/database');
const { generate } = require('generate-password');
const { mail } = require('../service/email');
const passport = require('passport');
const express = require('express');
const crypto = require('crypto');
const router = express.Router();

router.get('/signup', isNotLoggedIn, (req, res) => {
    res.render('auth/signup');
});

router.post('/signup', isNotLoggedIn, passport.authenticate('local.signup', {
    successRedirect: '/index',
    failureRedirect: '/signup',
    failureFlash: true
}));

router.get('/signin', isNotLoggedIn, (req, res) => {
    res.render('auth/signin');
});

router.post('/signin', isNotLoggedIn, async (req, res, next) => {
    passport.authenticate('local.signin', {
        successRedirect: '/index',
        failureRedirect: '/signin',
        failureFlash: true
    })(req, res, next);
});

router.get('/profile', isloggedIn, (req, res) => {
    res.render('profile');
});

router.post('/profile', isloggedIn, async (req, res) => {
    if (req.body.password !== '') { req.body.password = crypto.createHash('md5').update(req.body.password).digest('hex'); } 
    else { req.body.password = req.body.passUser; }
    delete req.body.passUser;

    let connection = await connectiondb();
    const update = await connection.query( 'UPDATE user SET ? WHERE id = ?', [req.body, req.body.id] );
    
    if ( update.changedRows > 0 ) {
        req.flash('success', 'Usuario actualizado correctamente.');
        res.redirect('/');
    } else {
        req.flash('success', 'Erro al intertar actualizar al usurio.');
        res.redirect('/profile');
    }
});

router.get('/logout', isloggedIn, (req, res) => {
    req.logOut();
    res.redirect('/signin');
});

router.get('/forgot', isNotLoggedIn, (req, res) => {
    res.render('auth/forgot');
});

router.post('/forgot', isNotLoggedIn, async (req, res) => {
    let connection = await connectiondb();
    const rows = await connection.query( 'SELECT * FROM user WHERE user = ?', [req.body.username] );

    if (rows.length > 0) {
        const password = generate({ length: 10, numbers: true });
        
        const passwordMD = crypto.createHash('md5').update(password).digest('hex');;

        const update = await connection.query( 'UPDATE user SET password = ? WHERE user = ?', [passwordMD, req.body.username] );

        if ( update.changedRows > 0 ) {
            await mail(
                { 
                    to: rows[0].mail,
                    subject: 'Recuperacion de Contraseña',
                    template: 'forgot',
                    context: { password }
                }
            );
        }
        
        req.flash('success', 'Se envio contraseña al correo registrado');
        res.redirect('/signin');
    } else {
        req.flash('message', 'El Usuario NO existe');
        res.redirect('/forgot');
    }
});

module.exports = router;