import "@stdlib/deploy";

contract SampleTactContract with Deployable {

    owner: Address;
    counter: Int as uint16;

    init(owner: Address) {
        self.owner = owner;
        self.counter = 0;
    }

//  ==================== Binary Msg Section Start  ====================
    message Add {
        amount: Int as uint32;
    }

    receive(msg: Add) {
        self.add(msg.amount);
        self.reply("incremented with Add msg".asComment());
        emit("emit incremented with Add msg ".asComment());
    }

    message Minus {
        amount: Int as uint32;
    }

    receive(msg: Minus) {
        self.minus(msg.amount);
        self.reply("decremented with Minus msg".asComment());
        emit("emit decremented with Minus msg ".asComment());
    }
//  ################## Binary Msg Section End  #########################

//  ==================== Textual Msg Section Start  ====================
    receive("increment") {
        self.add(1);
        self.reply("incremented".asComment());
        emit("emit incremented ".asComment());
    }

    // not meeting the condition will raise an error, revert the transaction and all state changes
    receive("increment with error") {
        self.val = self.val + 1;
        require(self.val != 0, "ERROR: Counter is too high!");
    }

     receive("decrement") {
         self.minus(1);
         self.reply("decremented".asComment());
         emit("emit decremented ".asComment());
     }

     // advanced: revert the transaction and return a specific non-zero exit code manually
     // https://ton.org/docs/learn/tvm-instructions/tvm-exit-codes
     receive("no access") {
         throw(132);
     }

    // if none of the previous receivers match the comment string, this one is called
    receive(msg: String) {
        dump("unknown textual message received:");
        dump(msg);
        self.reply("decremented".asComment());
    }

//  #####################################################################
//  ################## Textual Msg Section End  #########################


//  ------------------------ Internal Function Start ------------------------
   fun add(v: Int) {
        // Check sender use sender()
        require(sender() == self.owner, "Invalid sender");

        // Update counter
        self.counter = (self.counter + v);
    }

     fun minus(v: Int) {
            // Check sender use ctx.sender
         let ctx: Context = context();
         require(ctx.sender == self.owner, "Invalid sender");

         // Update counter
         self.counter = (self.counter - v);
     }
//  ##################################################################
//  ################## Internal Function End #########################

    get fun greeting(): String {
        return "hello world";
    }

    get fun counter(): Int {
        return self.counter;
    }

    get fun getter(): Int {
        return self.counter;
    }
}