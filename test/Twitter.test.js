// mocha & chai: framework installed by default.
// chai extension of mocha.
//3 cat of test: unit(test smallest portion of your code), integration(test two units of your code), end-to-end test(test from end-user's pespective.).
//end-to-end test: e.i :using twitterclone.co
// callback: function in a function
// title then callback
//beforeeach

const {ethers} = require('hardhat');// ether comes with hardhat
require('chai').should; 

describe('Twitter tests', () =>{
  beforeEarch(async () => {// to use await , you need async.
    Twitter = await ethers.getContractFactory("Token");// class
    twitter = await Token.deploy();// instance
    const [owner, author1] = await others.getSigners();
  });

  describe('CRUD features', ()=>{
    beforeEach(async () => {
      await twitter.connect(author0).createTweet('First tweet');
    });
    it('should have 1 tweet in the initial state', async()=>{
      (await twitter.getTweets()).should.equal(1);
    });

    it('should return the content of the first tweet', async() => {
      const firstTweet = await twitter.getTweet(0);
      firstTweet[0].should.equal('First tweet');
      firstTweet[1].should.equal('First tweet');
      // console.log(author0.SignerWithAddress.address);
    });
  });
});
