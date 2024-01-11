import "@stdlib/deploy";

struct Challenge {
        challengeId:Int as uint32;
        userId:String;
        gameId:String;
        betAmount:Int as uint16;
}

 message CreateChallenge {
           challengeId:Int as uint32;
           userId:String;
           gameId:String;

}

contract SampleTactContract with Deployable {

//  ==================== Contract Status Section Start  ====================
    owner: Address;
    seq: Int as uint16;
    init(owner: Address, seq: Int) {
        self.owner = owner;
        self.seq = seq;
    }

    challenges: map<Int, Challenge>;
//   ################## Contract Status Section End  #########################


//  ==================== Binary Msg Section Start  ====================
    receive(msg: CreateChallenge) {
       let c: Challenge = Challenge{
           challengeId: msg.challengeId,
           userId: msg.userId,
           gameId: msg.gameId,
           betAmount:5
       };

       self.challenges.set(msg.challengeId, c);
       self.reply(("Challenge Created.").asComment());
    }
//  ################## Binary Msg Section End  #########################


//  ==================== Textual Msg Section Start  ====================
    receive("join challenge") {
        self.reply("Challenge Joined.".asComment());
    }
//  ################## Textual Msg Section End  #########################




//  ------------------------ Internal Function Start ------------------------

//  ################## Internal Function End #########################



//  ------------------------ Getter Start ------------------------
    get fun challenges():map<Int, Challenge> {
        return self.challenges;
    }
//  ################## Getter End #########################

}