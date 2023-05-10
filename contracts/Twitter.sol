// SPDX-License-Identifier: SEE LICENSE IN LICENSE
// create 1st the .sol file then write pragma solidity
// specify the version of solidity compatible
pragma solidity >=0.8.0 <0.9.0;// make your code compatible with former version

// keyword to start your smart contract: contract <name>
contract Twitter{
  // uint public _myNumber = 0;
  // string public _myString = 'My initial value';
  // bool myBoolean;// default it is public and false
  // address myAddress = 0x25146983254d25548814c5;// public addr. of the smart contract
  // // private key + hash it to get your public key.

 // mapping (uint => address) public myMapping;// useful in card to specify the owner of the card

  struct Tweet {// 1st complex type used to define our tweet. by default all vars are public 
    uint256 id;//uint alias for uint256. How much memory taken. uint256 takes 256byte, while uint16 takes 256byte
    string content;
    address author;
    uint256 timestamp;
    bool deleted; // consistant gaz price to fetch delete and post new tweet
  }
  //convention add '_'  for variable parameter
  Tweet[] private _tweets; // this will act as our database.
  // in solidity we have fix and dynamic array.

  /**
   * 
   * @param _content get the 
   */
  // calldata: sth in mem that can be edited. defined by user using it.
  // external: call by the outside outside user. 
  // public, private, external
  function createTweet(string calldata _content) external{// working with complex type, specify how it should be treated. 
  // 3 type data location when dealing  with complex type: storage, memory(allocate mem and delete it) and calldata(can't edit the variable)
  // when you 
  Tweet memory newTweet;// must be memory bcz we want to edit it
  newTweet.content = _content;
  newTweet.author = msg.sender;// global var. the any smart contract can access. msg.msg.sender
  // msg.data = all the meta data. 
  // msg.sender : return the address of the sender
  newTweet.timestamp = block.timestamp;
  newTweet.id = _tweets.length;
  //tweetIdToOwner[_tweets.length] = msg.sender;
  newTweet.deleted = false;

    _tweets.push(newTweet);// array has the length, push, pop method.
  }

  /**
   * 
   * @param _id The id of the tweet you want to fetch
   * @return A specific tweet, given an id
   */
  // view:; they don't write anything to the blockchain and they won't cost a thing.
  function getTweet(uint256 _id) external view returns(Tweet memory){// calldata the user has to define it.
    require(_tweets[_id].deleted == false, 'The tweet you are searching is deleted');
    return _tweets[_id];
  }

  /**
   * returns all the tweets
   */
  // why specify return type bcz when you compile the code, the compiler will check the squeleton of your function so that the 'abi' will check only the shape.
  function getTweets() external view returns(Tweet[] memory){ // view bcz you are not writing anything on the blockchain 
  // each time you call a function you pay in gass(converted in ethers) except when you view
      Tweet[] memory returnTweets;
      uint256 j;
      // Go through the entire array of tweets and only return the not-deleted tweets
      for(uint256 i = 0;  i < _tweets.length; i++){
        if(_tweets[i].deleted == false){
          returnTweets[j] = _tweets[i];
          j++;
        }
      }
      return returnTweets;
  }


  /**
   * 
   * @param _id the id of the tweet to be updated
   */
  // require: check for condition. defie the 1st argument and goes on forward if true.
  function updateTweet(uint _id, string calldata _newContent) external {
    require(_tweets[_id].deleted == false, 'The tweet you are searching is deleted');
    require(_tweets[_id].author == msg.sender, 'Only the author of the tweet can edit it');
    _tweets[_id].content = _newContent;
  }


  function deleteTweet(uint256 _id) external{
    require(_tweets[_id].deleted == false, 'You are trying to delete ');
    require(_tweets[_id].author == msg.sender, 'Only the author of the tweet can edit it');
    _tweets[_id].deleted = true;
  }
  
}


