var HolyCoin = artifacts.require("./HolyCoin.sol")
describe("HolyCoin", () => {
	contract("transfer", (accounts) => {
		it("should buy 10000", () => {
			return Promise.resolve()
			.then(() => HolyCoin.deployed())
			.then(() => {
				instance = web3.eth.contract(HolyCoin.abi).at(HolyCoin.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 100000})
			})
		})
		it("buy 10" , () => {
			return Promise.resolve()
			.then(() => {
				instance = web3.eth.contract(HolyCoin.abi).at(HolyCoin.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10})
			})
		})
		it("print values", () => {
			return Promise.resolve()
			.then(() => {
				for (let i = accounts.length - 1; i >= 0; i--) {
					instance = web3.eth.contract(HolyCoin.abi).at(HolyCoin.address)
					console.log("amount in acc", i, instance.balanceOf(accounts[i]))
				}
			})
			.then(() => {
				console.log("confession:", web3.toAscii(instance.confess("example")))
			})
		})
	})
})
