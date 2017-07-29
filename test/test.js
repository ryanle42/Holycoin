var Crowdsale = artifacts.require("./Crowdsale.sol")
describe("Crowdsale", () => {
	contract("transfer", (accounts) => {
		
		it("should transfer 10000", () => {
			return Promise.resolve()
			.then(() => Crowdsale.deployed())
			.then(() => {
				instance = web3.eth.contract(Crowdsale.abi).at(Crowdsale.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10000})
			})
		})
		it("transfer 10" , () => {
			return Promise.resolve()
			.then(() => {
				instance = web3.eth.contract(Crowdsale.abi).at(Crowdsale.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10})
			})
		})
		it("print accounts", () => {
			return Promise.resolve()
			.then(() => {
				for (let i = accounts.length - 1; i >= 0; i--) {
					instance = web3.eth.contract(Crowdsale.abi).at(Crowdsale.address)
					console.log("amount in acc", i, instance.balanceOf(accounts[i]))
				}
			})
		})
	})
})