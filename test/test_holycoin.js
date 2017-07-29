var Holycoin = artifacts.require("./HolyCoin.sol")
describe("Holycoin", () => {
	contract("transfer", (accounts) => {
		it("should transfer 10000 to account 0", () => {
			return Promise.resolve()
			.then(() => Holycoin.deployed())
			.then(() => {
				instance = web3.eth.contract(Holycoin.abi).at(Holycoin.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10000})
				console.log("amount in acc 0 ", instance.balanceOf(accounts[0]))
			})
		})
		it("transfer -10 to account 0" , () => {
			return Promise.resolve()
			.then(() => {
				instance = web3.eth.contract(Holycoin.abi).at(Holycoin.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: -10})
				console.log("amount in acc 0 ", instance.balanceOf(accounts[0]))
			})
		})
		it("print accounts", () => {
			return Promise.resolve()
			.then(() => {
				for (let i = accounts.length - 1; i >= 0; i--) {
					instance = web3.eth.contract(Holycoin.abi).at(Holycoin.address)
					console.log("amount in acc", i, instance.balanceOf(accounts[i]))
				}
			})
		})
	})
})
