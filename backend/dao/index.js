const userDao = require('./userDao');
const accountDao = require('./accountDao');

module.exports = {
    ...userDao,
    ...accountDao,
};