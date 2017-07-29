var Crowdsale = artifacts.require("./Crowdsale.sol")
describe("Crowdsale", () => {
	contract("transfer", (accounts) => {
		it("should transfer 10000", (done) => {
			(async () => {
				await Crowdsale.deployed()
				console.log("transferring 10000 holycoin to account 0")
				let instance = web3.eth.contract(Crowdsale.abi).at(Crowdsale.address)
				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10000})
				console.log("amount in acc 0 ", instance.balanceOf(accounts[0]))

				web3.eth.sendTransaction({from: accounts[0], to: instance.address, value: 10000})

				for (let i = accounts.length - 1; i >= 0; i--) {
				console.log("amount in acc", i, instance.balanceOf(accounts[i]))
				}
				
			})().then(() => done(), done);
		})
	})
})
