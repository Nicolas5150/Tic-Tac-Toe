//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Nicolas Emery on 8/7/15.
//  Copyright © 2015 Nicolas Emery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // create active player
    // 1 = X && 2 = O
    var activePlayer:Int = 1;
    // create a char with no one as the winner at first
    var player:String = "No one";
    // is game still running bool
    var gameActive = true;
    // turns left until draw
    var turnsLeft:Int = 9;
    // create an array for knowledge of board and x/o locations
    var gameState:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    // create an array list of winning combinations
    var winningWays:Array = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]];
    
    // X/O buttons
    @IBOutlet var button: UIButton!
    // playButton
    
    @IBOutlet var playButton: UIButton!
    
    // playAgain button action
    @IBAction func playAgain(sender: AnyObject)
    {
        // hide the play again button until game is over
        playButton.hidden = true;
        playButton.center = CGPointMake(playButton.center.x - 400, playButton.center.y)
        
        // reset all needed varaibles
        // active player
        // 1 = X && 2 = O
        activePlayer = 1;
        // create a char with no one as the winner at first
        player = "No one";
        // is game still running bool
        gameActive = true;
        // turns left until draw
        turnsLeft = 9;
        // knowledge of board and x/o locations
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
        
        // create a loop to clear all images off the board
        var button:UIButton
        for var i:Int = 0; i < 9; i++
        {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: .Normal)
        }
    }// end of playAgain button action
    
    @IBAction func buttonPressed(sender: AnyObject)
    {
        // check to see if an array spot (part of the board) has already been selected and if the game is still running (if win has occured)
        if (gameState[sender.tag] == 0 && gameActive == true && turnsLeft != 0)
        {
            // use a blank image to decare var but if/else will give it correct image (of X or O)
            var image = UIImage();
            // set postion X/O went on to active player
            gameState[sender.tag] = activePlayer;
        
            // player 1 turn
            if (activePlayer == 1)
            {
                // declare var then change image to a O if tapped
                // force unwrap the image becuase we know it's valid
                image = UIImage(named: "nought.png")!;
                // minus a turn
                turnsLeft = turnsLeft - 1;
                // change player to 2
                activePlayer = 2;
            }
            else
            {
                // declare var then change image to a X if tapped
                // force unwrap the image becuase we know it's valid
                image = UIImage(named: "cross.png")!;
                // minus a turn
                turnsLeft = turnsLeft - 1;
                // change player back to 1
                activePlayer = 1;
            }
            // map each button from the view controller scene
            // this is done by doing ctrl and then dragging ontop of this action
            // use "sender.set" instead of button.set"
            // allows the code to know which button was pressed
            sender.setImage(image, forState: .Normal)
            // print to console the tag used for each button as an ID
            //print(sender.tag);
        
            // loop through the combinations of wins possible
            // if the 0 spot changes it causes the check
            for combination in winningWays
            {
                if(gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]])
                {
                    // O wins the game
                    if (gameState[combination[0]] == 1)
                    {
                        print("O has won");
                        player = "O";
                        // allert the user that there is a winner
                        popUpMessage();
                    }
                    // X wins the game
                    else
                    {
                        print("X has won");
                        player = "X";
                        popUpMessage();
                    }
                    // disable more input by not satisifying the top if statment that checks if game is active
                    gameActive = false;
                    
                    // show option to play again
                    playButton.hidden = false;
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.playButton.center = CGPointMake(self.playButton.center.x + 400, self.playButton.center.y)})
                }// end of if statment for O to win
            }// end of combinations for loop
            
            // No one wins the game
            if (turnsLeft == 0 && player == "No one")
            {
                // call up winner box with no one's name
                popUpMessage();
                // show the play again option
                playButton.hidden = false;
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.playButton.center = CGPointMake(self.playButton.center.x + 400, self.playButton.center.y)})
            }// end of if np turns are left
        }// end of if game is active
    }// end of button tap
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // hide the play again button until game is over
        playButton.hidden = true;
        playButton.center = CGPointMake(playButton.center.x - 400, playButton.center.y)
        // Do any additional setup after loading the view, typically from a nib.
    }// end of viewDidLoad func

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }// end of didRecieveMemoryWarning func

    // create a function to display a popup modal message with the winner
    func popUpMessage()
    {
        let alertController = UIAlertController(title: "Winner", message: "\(player) has won!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) { }
    }// end of popUpMessage
}// end of code

