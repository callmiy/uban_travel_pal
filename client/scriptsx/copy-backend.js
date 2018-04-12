const path = require('path');
const copydir = require('copy-dir');

const buildDir = path.resolve('.', 'build');
const deployDir = path.resolve('..', 'server', 'web-client');
copydir.sync(buildDir, deployDir);
