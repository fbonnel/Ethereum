var Test = artifacts.require("./Test.sol");

contract('Test', function (accounts) {

  beforeEach('setup instance', async function() {
    ctInstance = await Test.new()
  })

  it('Jouer', async function() {
    await ctInstance.jouer({from: accounts[0] , value: 120})
      .then(function(result){
        console.log('test Jouer ok');
      })
      .catch(function(err){
        console.log('Erreur: ' + err);
      })
  })

  it('Classement', async function() {
    await ctInstance.jouer({from: accounts[1] , value: 1000000000000000000})
    await ctInstance.classement()
      .then(function(result){
        console.log(result);
        console.log('test Classement ok');
      })
      .catch(function(err){
        console.log('Erreur: ' + err);
      })
  })

  it('Reinitialisation', async function() {
    var vainqueur
    await ctInstance.jouer({from: accounts[1] , value: 1000000000000000000})
    await ctInstance.reinit({from: accounts[0]})
      .then(function(result){
        console.log('test Reinit ok');
      })
      .catch(function(err){
        console.log('Erreur: ' + err);
      })
      await ctInstance.vainqueur()
      .then(function(result){
        vainqueur = result;
        console.log(result);
      })
    assert(vainqueur == 0x0000000000000000000000000000000000000000, 'ERREUR!')
  })

})
