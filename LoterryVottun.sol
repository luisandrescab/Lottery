// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract LotteryVottun {
    address payable [] public players; 
address payable public  admin;
constructor () {
    admin = payable (msg.sender);
}

receive() external payable { 
 require(msg.value== 1 ether, "Must be 1 eth to play");
 require(msg.sender != admin, "admin can't play");
players.push (payable(msg.sender));

}


function getbalance () view public returns (uint){
    return address (this).balance;
}
function random () internal view returns (uint){
return uint (keccak256(abi .encodePacked(block.prevrandao, block.timestamp, players.length)));
}

 function pickwinner () public {
    require ( admin == msg.sender, "you are not owner");
    require (players.length >= 4, "There are not enough players to participate in the lottery");
   address payable  winner;
   winner= players [random()% players.length];

   winner. transfer( getbalance());
   players = new address payable [] (0);


 }

}
