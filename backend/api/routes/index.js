const express = require("express");
const { getHealthStatus } = require("../controllers/healthController");
const router = express.Router();

router.get('/status', getHealthStatus);

module.exports = router;