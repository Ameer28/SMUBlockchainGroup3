import Web3 from 'web3'
import WillContract from '/Users/Ameer Pestana/Desktop/SMU Projects/Group Project/abiDefinition.json'
import TruffleContract from 'truffle-contract'

(function ($) {
    'use strict';

    /*[ File Input Config ]
        ===========================================================*/
    
    try {
    
        var file_input_container = $('.js-input-file');
    
        if (file_input_container[0]) {
    
            file_input_container.each(function () {
    
                var that = $(this);
    
                var fileInput = that.find(".input-file");
                var info = that.find(".input-file__info");
    
                fileInput.on("change", function () {
    
                    var fileName;
                    fileName = $(this).val();
    
                    if (fileName.substring(3,11) == 'fakepath') {
                        fileName = fileName.substring(12);
                    }
    
                    if(fileName == "") {
                        info.text("No file chosen");
                    } else {
                        info.text(fileName);
                    }
    
                })
    
            });
    
        }
    
    
    
    }
    catch (e) {
        console.log(e);
    }

})(jQuery);

export function setProvider() {
    if (window.ethereum) {
        const ethereum = window.ethereum
        const web3Provider = new Web3(ethereum)

        /*make web3Provider available to entire app now */
    }
}

ethereum.enable().then((account) =>{
    const defaultAccount = account [0]
    web3Provider.eth.defaultAccount = defaultAccount
})

const ProofOfExContract = TruffleContract(ProofOfExistence)

ProofOfExContract.setProvider(web3Provider.currentProvider)
ProofofExContract.defaults({from: web3Provider.eth.defaultAccount})