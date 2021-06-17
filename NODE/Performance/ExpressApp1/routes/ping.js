var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', async function (req, res) {
    return res.status(200).send('Pong');
});

module.exports = router;
