const HDWalletProvider = require("truffle-hdwallet-provider"); // eslint-disable-line

module.exports = {
    compilers: {
        solc: {
            version: "0.6.2",
            parser: "solcjs",
            settings: {
                // optimizer: {
                //     enabled: true,
                //     runs: 200,
                // },
                // evmVersion: "istanbul",
            },
        },
    },
    networks: {
        //truffle develop
        // test: {
        //     host: "127.0.0.1",
        //     port: 9545,
        //     network_id: "*", // Match any network id
        // },
        mainnet: {
            network_id: "1",
            provider: () =>
                new HDWalletProvider(
                    process.env.TRUFFLE_MAIN_DEPLOYER,
                    process.env.TRUFFLE_MAIN_PROVIDER
                ),
            gasPrice: 75000000000,
            gas: 9500000,
        },
        rinkeby: {
            network_id: "4",
            provider: () =>
                new HDWalletProvider(
                    process.env.TRUFFLE_RINKEBY_DEPLOYER,
                    process.env.TRUFFLE_RINKEBY_PROVIDER
                ),
            gasPrice: 50000000000,
            gas: 9500000,
        },
        bsctest: {
            network_id: "97",
            provider: () =>
                new HDWalletProvider(
                    process.env.TRUFFLE_BSCTEST_DEPLOYER,
                    process.env.TRUFFLE_BSCTEST_PROVIDER
                ),
            gasPrice: 20000000000,
            gas: 7500000,
        },
        bscmain: {
            network_id: "56",
            provider: () =>
                new HDWalletProvider(
                    process.env.TRUFFLE_BSCMAIN_DEPLOYER,
                    process.env.TRUFFLE_BSCMAIN_PROVIDER
                ),
            gasPrice: 20000000000,
            gas: 7500000,
        },
    },
};
