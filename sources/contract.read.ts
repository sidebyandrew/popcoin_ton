import {Address, contractAddress} from "@ton/core";
import {TonClient4} from "@ton/ton";
import {SampleTactContract} from "./output/sample_SampleTactContract";
import {_ENDPOINT_MAINNET, _ENDPOINT_TESTNET, _OWNER, _TEST_ONLY} from "./global.config";

(async () => {
    const client = new TonClient4({
        endpoint: _TEST_ONLY ? _ENDPOINT_TESTNET : _ENDPOINT_MAINNET
    });

    // Parameters
    let testnet = true;
    let packageName = "sample_SampleTactContract.pkg";
    let owner = Address.parse(_OWNER);
    let init = await SampleTactContract.init(owner,1n);
    let contract_address = contractAddress(0, init);

    // Preparing
    console.log("Reading Contract Info...");
    console.log(contract_address);

    // Input the contract address
    let contract = await SampleTactContract.fromAddress(contract_address);
    let contract_open = await client.open(contract);
    console.log("getChallenges(): " + (await contract_open.getChallenges()));
})();
