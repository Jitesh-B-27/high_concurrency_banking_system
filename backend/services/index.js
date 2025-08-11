const userService = require("./userService");
const accountService = require("./accountService");

module.exports = {
    ...userService,
    ...accountService,
};