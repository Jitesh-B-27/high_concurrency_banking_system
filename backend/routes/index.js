const express = require("express");
const { getHealthStatus } = require("../controllers/healthController");
const { createUserController } = require("../controllers/userController");
const router = express.Router();

router.get('/status', getHealthStatus);
router.post('/users', createUserController);

module.exports = router;