var FlashLoanExample = artifacts.require("FlashLoanExample");

var path = require("path");
var deployenv = require(path.join(path.dirname(__dirname), "deployenv.json"));

module.exports = async function (deployer, network) {
    network = /([a-z]+)(-fork)?/.exec(network)[1];
    var provider = deployenv[network].provider;
    if (!provider) {
        throw new Error("not flashloan provider");
    }
    await deployer.deploy(FlashLoanExample, provider);
    console.log("FlashLoanExample deploy at: ", FlashLoanExample.address);
};
