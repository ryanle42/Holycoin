var HolyCoin = artifacts.require("./HolyCoin.sol")
describe("HolyCoin", () => {
	contract("transfer", (accounts) => {
		;(async () => {
			await HolyCoin.deployed()
			let instance = web3.eth.contract(HolyCoin.abi).at(HolyCoin.address)

			web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10000})
			instance.transfer(accounts[1], 10000, {from: accounts[0]})
			instance.approve(accounts[0], 100, {from: accounts[1]})
			instance.transferFrom(accounts[1], accounts[2], 100, {from: accounts[0]})
			for (let i = accounts.length - 1; i >= 0; i--) {
			console.log("amount in acc", i, instance.balanceOf(accounts[i]))
			}
		})().catch(console.error)
	})
})