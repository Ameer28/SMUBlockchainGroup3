pragma solidity ^0.6.0;

contract WillContract {
    
    enum lodgeStatus { submitted, lawyersigned, witnessok, completed  }
    
    struct will {
        
        address testatorAddress;
        address lawyerAddress; // lawyer's account address
        address witnessAddress; // witness account address
        uint8 willCount; // number of wills submitted by a particular testator
        lodgeStatus willStatus;
        
        
    }
    
    event submitted (address testator);
    event replacementWillSubmitted (address testatorAdd);
    event laywercompleted (address testator);
    event witnesscompleted (address testator);
    event willcompleted (address testator);
    mapping(address => will) public wills;

    
    //function to create a new will, and add to 'wills' map. requires at least 0.01ETH to create
    function add() public payable returns (uint8) {
        //check if will exists 
        
        if (wills[tx.origin].willCount > 0 )  {
        // set the lawyer and witness address to address (0)
            wills[tx.origin].lawyerAddress = address(0);
            wills[tx.origin].witnessAddress = address(0);
            wills[tx.origin].willStatus = lodgeStatus.submitted;    
            emit replacementWillSubmitted(tx.origin);
        } // end of if  
        else 
        {
            //new will object
            will memory newWill = will(
                tx.origin, // testator (owner)
                address(0), // lawyer has not signed, so use 0 as address
                address(0), // witness has not signed, so use 0 as address
                0, // number of wills (willcount) is initalised to 0 
                lodgeStatus.submitted

            );
            
            wills[tx.origin] = newWill;
            //commit to state variable
            emit submitted (tx.origin);
        } // end of else

        
        return wills[tx.origin].willCount++;
    }

   
    //lawyer sign on a will     
    function lawyerSign (address testatorAdd) public {
            wills[testatorAdd].willStatus = lodgeStatus.lawyersigned;    //set status to lawyersigned
            wills[testatorAdd].lawyerAddress = msg.sender;    //set the the laywer address to the laywer's key address
            emit laywercompleted(testatorAdd);
    }

    function witnessSign(address testatorAdd) public  {
            wills[testatorAdd].willStatus = lodgeStatus.witnessok ; //set status to witnessok
            wills[testatorAdd].witnessAddress = msg.sender;
            emit witnesscompleted (testatorAdd); //emit witness completed signing
    }
    
    //check completeness of signing. If completed, change status to completed 
    function checkcompleteness(address testatorAdd) public {
         if ( ( wills[testatorAdd].lawyerAddress != address(0) ) && ( wills[testatorAdd].witnessAddress != address(0) ) )  {
          wills[testatorAdd].willStatus = lodgeStatus.completed ;
          emit willcompleted(testatorAdd);
      } // end if statement
    }
      
}

