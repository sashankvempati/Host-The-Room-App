# The RoomApp- Walkthrough GIF

<img src="https://recordit.co/WtmCsuXzbp.gif" width=250><br>

# The RoomApp- Algorithm
# KEY: 
 **@IB Action** Action event buttons that executes a function when triggered
 
 **GOTO** Navigates to a particular View Controller/ Screen
 
 **DISMISS** Show what buttons there are to dismiss a popup error message
 
 **For Notifications and automatic messages from App** An A.I. bot sends these messages/ notifications/ instructions to both user and host through the chat. This can be used to get any sort of help within the app and service. This wont spam your chats. To chat with this bot, user switches mode to "bot" from "host"/ "user" that is right beside the message entry text field
    
**Possible name: Mac**

# User

## Login/ Signup

### Login

**@IBAction** when login button is pressed{

	if username/ password is not nil {
		
        if username/ password is incorrect {
            Error message: "Incorrect username or password"
            DISMISS: *OK*
            Button: "Forgot username/ password? Click to reset"
        }
        else{
            GOTO: Available Rooms View Controller
        }
	}
	else {
        Don't do anything. 
        if Login button is pressed more than 5 times {
            Error message: "Please enter a username and password"
            DISMISS: *OK*
        }
	}
}

### Signup/ Verify profile using ID
**@IBAction** when Create a New Account button is pressed {

    GOTO: Sign Up View Controller
}

**@IBAction** when Sign Up button is pressed{

    if username, password, photo, email, phone number are not nil {
        if password != confirm password {
            Error message: "The passwords do not match"
        }
        else{
            GOTO: Verify by email/ phone number and enter the code sent

            Button: "Generate another code" in case code is not sent
            if incorrect code has been entered{
                Error Message: "Incorrect code entered. Please try again"
            }
            if code entered is successful {
                GOTO: Setup Payment Methods
            }
        }
    }
    else {
        Error message: "Please enter in [Whatever needs to be filled]"
    }
}

**@IBAction** when user clicks on verify profile button {

    GOTO: Camera
    takes a picture of their face + hand gestures for authenticity
    using ML and computer vision, it verifies that user and profile photo match
    User then scans a government issued ID or passport
    verifies with the above two picutres using computer vision for final authentication
    User gets a verified label after their name on profile and when booking

    User can also verify email and phone number for even stronger verification and more trust
}

if user skips verify profile, remind user again to verify profile before reserving a space if they havent verified yet
also notify user that they could verify profile in the "My Profile" section in Settings tab
User cannot reserve a space without verifying their account.

### Add Payment Method 

**@IBAction** when Payment method is added {

    if credit card/ other payment method is verified and approved {
        Success!
        Show the added card
        ask if they want to add money to account (default account balance: 0)
        GOTO: Terms and Conditions View Controller 
    }
    if user skips this step {
        ask user to add payment method before reserving/ hosting a room
    }
    if user has referral code and enters it in voucher section {
        if code is valid {
            add cash to user's account balance
        }
        if code is not valid {
            "Error message: "Code is not valid. Please try another code."
        }
    }
}

## User goes to Terms and Conditions (very explicit, strict regulations to avoid misusing)
**@IBAction** when user clicks on "Agree" and checks all the boxes {

    if any of the boxes are not checked {
        Error Message: "Please make sure you agree to all the terms and conditions before proceeding"
        DISMISS: "OK"
    }
    GOTO: Available Rooms View Controller
}

## User goes to Available Rooms View Controller

### if this is a user's first time coming to this view controller after logging in OR if the "filters" button is pressed

**@IBAction** when all filters are set (date, time, location, distance, price) {

    query the database based on these parameters
    For time:
    - Actual clock (12:15pm, 2:45 pm)
    - Timer (10 minutes from now, 25 minutes from now, etc.)
    If no filters are set, sort listings based on distance and are available now
    Default filters: 
    - Date and time: right now
    - Location: user's city (using GPS)
    - Distance: first 10 listings based on distance (within 1-2 miles)
}

**@IBAction** when "Map" button is pressed at top right corner {

    Show a google maps view of all listings, put dots at corressponding listings
}

### User browses through/ books a space

**@IBAction** when user clicks on a listing {

    Query the database for the image, description, price, people capacity general area of space in maps with a circle
    Query the database for the host's profile picture, bio, star rating
    Button: "Book Now"
    GOTO: View Controller: Select how many hours to book (minimum is 1 hour)
        Note: if space is booked for a future time, notify the current user about room availability
        View Controller: Select number of people (Range: 1 - capacity of space)
    Button: "Confirm reservation"
}

**@IBAction** when user confirms number of people {

    GOTO: Confirmation View Controller to give a receipt- breakup of expenses (cost price, service charges, tax)
    Charge user's credit card using Stripe's API/ Payment Method
    2% + $0.30 of total cost goes to Stripe 
    The RoomApp takes a 20% cut from the remaining cost
    The rest of the 80% goes to host, they get their money deposited into their account beginning of every hour
    Screen Says: "To check in, click on this listing in Reserved Rooms View Controller Tab to scan QR code"
} 

the space listing appears on the user's Reserved Rooms tab

### User can chat with host or vice versa (if they want) in a separate tab (user has to first tap the message button in host's bio/ listing)

**@IBAction** when user taps on message icon under the host's info to talk to host {

    GOTO: Messages tab
    User can message host
    if user taps on host's name on the top{
        GOTO: Host's Profile + Bio
    } 
    if user does not book space{
        messages are deleted by default after 2 hours
    } 
    if user books space{
        "H" Mark will appear after host's name for distinction
        messages are deleted 24 hours by default after reserved date
    } 
    Users can save messages in chats if they want (tap and hold on message to save)
}

## User goes to Reserved Rooms View Controller

### Whatever listing user booked appears here

if user booked any spaces {

    query the database for listing and its details 
    show all listings that are booked by user for future reservations
}

### User gets the exact location of venue for the space

for all the spaces available {

    show the exact location/ address for all the spaces
}

### User gets a confirmation receipt and verification code

**@IBAction** when user presses "OK" on confirmation screen {

    DISMISS: Current Screen
    GOTO: Reserved Rooms View Controller
}

### [Check-in]- User uses a QR code scanner to unlock door/ lockbox to get keys

**@IBAction** when user taps the QR code button in listing details {

    Show the QR Code Scanner Screen
}

**@IBAction** when user scans the QR code {

    For the specific room, exact qr code 
    If a host is lending out 2 or more rooms, then QR codes for all those rooms will be registered with the main door to unlock it.

    if QR Code matches with the room user reserved {
        tell lockbox/ door lock to unlock
        User's unique key is stored in the lockbox/ door database so they can re-unlock again
        if lockbox/ door lock is unlocked for >20 seconds {
            lock the lockbox
            unlock if user scans the qr code again
        }
    } else {
        Error: "QR Code does not match. please try again."
        if Error pops up for more than 5 times {
            Host is notified for help/ security
        } 
    }
}

if room lock is not unlocked within 5 minutes after unlocking main door {

    activate sensors to see where user is
    notify the host for them to track user for security measures
}

### User gets reminder couple minutes before reservation time ends

**@IBAction** OK is pressed when reminder pop us is presented {

    DISMISS: popup message
}

**@IBAction** when screen pops up if they want to reserve for more time {

    if YES {
        Ask for how many more hours
        if anyone else reserved during that time {
            Give a warning, mention how much time is left for next reservation 
        }
        Add the extra time to the database for user and locks 
        Charge for extra time + extra charges/ taxes 
        Additional convenience fee (0-50% hourly rate for every hour reserved, depending on customer demand and traffic)
            - Could use AI for this to determine hourly rate bassed on customer traffic, demand, and location
        Host is notified that user is staying for extra time and that host will get paid accordingly
    }
    if NO {
        make sure user leaves on time, give reminders accordingly
    }
}

if user's unique key is stored and they did not pay for extra time {

    Charge them room charge + tax + fine for every additional minute spent
}

### [Check-out]- User scans the lockbox again so that the key is back/ door is locked and ready to for the next user

**@IBAction** when user scans the QR code {

    User's unique key is removed from the lockbox/ door lock database
    When checking out, user must close the door and check out from the outside
    if user unlocks the door when no key is there {
        alarm will go off, can only be stopped by host's id or through their app
        host will be notified 
    }
    when user checks out of house, same procedure should be done with the main door.
    if user does not check out within 5 minutes of checking out of main door {
        motion cameras will be activated for security
        host will be notified
    } 
    if user checks out successfully {
        GOTO: Review Host View Controller
    }
} 

### User is asked to rate/ review/ tip/ complement host

**@IBAction** when "Done" button is pressed {
    
    Reviewing the host {
        Rate them out of 5 stars
        Give a complement (some buttons are excellent service, smooth check in check out, great ambience/ amenities, etc.)
        Add a comment for feedback
        Give a tip (15%, 20%, 25%, custom). if custom, only absolute values are taken
    }
    if any/ all the user feedback = nil {
        Default rating = 5 stars, add to host's overall rating
    }
    if user filled out any of the feedback {
        Complements get tallied on host's bio
        Comments are added to host's bio under comments section
        user rating is added to the host's overall average rating
        if rating < 5 stars {
            ask user why by giving list of reasons including "other", for custom reason
            list of reasons varies by star rating
        }
        Tips are added to host's account directly, host is notified
    }
    if reservation of space is done, user checked out, and gave a rating {
        the space listing goes to the history/ archive tab, found in the sidebar navigation or settings tab
        location map changes back to highlighted general region
    }
}


## User goes to Settings

**@IBAction** when "My Profile" button is pressed {

    GOTO: My Profile View Controller
    Show User's Photo, Bio, Name, Phone number, email
    Button at the Bottom: "Verify my profile" if user did not verify
    if verified, it will show on user's profile when booking so host has more trust
}

**@IBAction** when user clicks on verify profile button {

    GOTO: Camera 
    takes a picture of their face + hand gestures for authenticity
    using ML and computer vision, it verifies that user and profile photo match
    User then scans a government issued ID or passport
    verifies with the above two picutres using computer vision for final authentication
    User gets a verified label after their name on profile and when booking

    User can also verify email and phone number for even stronger verification

    Once verified, The Verify profile button disappears
}

**@IBAction** when "Payments" button is pressed {

    GOTO: Payments View Controller
}

### Update Profile

**@IBAction** when "Save" button is pressed {

    if any user details (photo, name, email, etc.) = nil {
        Error Message: "Please enter in all the user details."
        DISMISS: "OK" button
    }
    if all user details != nil {
        if user photo != a person's face or is not verifiable with given ID Photo {
            "Error message: Please make sure you upload a picture of you."
        }
        update all the info user gave in textfields and image view to database
    }
}

### Update Payment Method

**@IBAction** when "Add Card" button is pressed {

    add a credit/ debit card 
    verify the card and add it to payments list
    Card is added to database
}

**@IBAction** when "Add Cash to Account" button is pressed {

    ask user how much money to add 
    suggested: $20, $40, $60, custom (absolute value)
    In case there isn't enough balance, money is drawn from selected card
    Amount value is added to database
}

**@IBAction** when "Add coupon code" button is pressed {

    if coupon code = valid {
        add corresponding cash value to user's account balance
    }
    if coupon code != valid {
        Error message: "Please enter in a valid coupon code"
        DISMISS: "OK" Button
    }
}


# Host

## Navigate to Host Account from User Account
**@IBAction** when user presses "switches to host" button {

    if host account is not created {
        GOTO: Create Host Account View Controller
    }
    if host account already exists {
        GOTO: Dashboard View Controller
    }
}

## Create Host Account
**@IBAction** when host clicks on the sign up button {

    Details from User account are used
    GOTO: Terms and Conditions 
}

### Host goes to Terms and Conditions (separate for hosts)
**@IBAction** when user clicks on "Agree" and checks all the boxes {

    if any of the boxes are not checked {
        Error Message: "Please make sure you agree to all the terms and conditions before proceeding"
        DISMISS: "OK"
    }
    GOTO: Background Check View Controller
}

### Background Check (First time hosts only)
Host will not be able to post rooms or spaces publicly without doing a background check and getting approved.

**@IBAction** when host schedules a time to do a background check{

    1 of 2 possibilities:
    - someone will visit (will show their ID) to clear host during scheduled time
    - host has to go to an office 

    For background checks, prospective host has to:
    - add extra personal details
    - SSN 
    - work authorization
    - insurance
    - bank details

    if background check is approved {
        release permission to add rooms/ spaces to host
    }
}

GOTO: Training Videos View Controller
make sure that user watches all the training videos for:
    - how to host a space
    - how to get insured
    - how to post a room online
    - how to redeem money online

GOTO: Payment Method View Controller

### Host goes to Payment method to add bank/ card details
**@IBAction** when "Add Bank Details" button is pressed {

    if bank details (account number, routing number) or card details are verified {
        Message: "Success!"
        show the bank details or card number
        GOTO: Dashboard View Controller
    }
    if none of these details are verified {
        Error message: "Please enter another bank account number or a card number"
    }
    Account balance for host account is the same as their user account. 
}

## Host goes to Dashboard View Controller

### Host looks at account balance [TODO]

### Host can make their spaces online/ offline

Note: by default, spaces are online and can be viewed publicly. 
    - Hosts that want to make their spaces offline can do so with these two modes
    - The first mode (this one) can make a space offline immediately
    - The second mode (The next one) makes a space offline on a periodic basis
    - If user tries to book a space on a blackout day, the bot notifies them and tells them the next available date of that particular space

if hosts have only one space {

    Go online/ offline toggle switch or a circular button that gets highlighted
}
if hosts have multiple spaces {

    Button: "Update Room statuses"
    if this button is pressed {
        show a list of all rooms added by host
        each room listing will have a toggle switch on the right side to go online/ offline
    }
}

Going online- Listing can be viewed publicly
Going offline- Listing will be hidden publicly

### Host can set one time/ periodic black out dates for specific rooms on a daily, weekly, or monthly basis

if hosts have only one space {

    The "schedule time" button opens up a daily, weekly, or monthly calendar 
    user can highlight dates and times that space is blacked out for
}
if hosts have multiple spaces {

    The "schedule time button" opens a list of user's spaces
    if user taps on a space, a calendar shows up that is daily weekly, and monthly
    user can highlight dates and times that space is blacked out for
}

## List of customers View Controller

### When user book a host's room

if customer books a host's room/ space {

    If a user books a host's room, the host is notified by the bot through the chat tab. 
    This notification would appear under that specific customer's chat.
}

### When host taps on a customer from the list

**@IBAction** Host taps on a customer from the list {

    GOTO: Customer Details View Controller
    show all the details of customer, including name, bio, picture, email
    show details of the reservation (date, time, duration (hours), how many people, total cost)
    retrieve all this information from database
}

### Chatting: done in a separate tab

**@IBAction** when host taps on message icon under the user's info to talk to user {

    GOTO: Messages tab
    Host can message user
    if host taps on user's name on the top{
        GOTO: User's Profile + Bio
    } 
    if user does not book space{
        messages are deleted after 2 hours by default
    } 
    if user books space{
        "C" Mark will appear after user's name for distinction
        messages are deleted 24 hours by default after reserved date
    } 
    Hosts can save messages in chats if they want (tap and hold on message to save)
}


## Host goes to My Rooms/ Spaces tab

### Add a Room/ Space

**@IBAction** when "+" button is pressed in My Rooms View Controller {

    GOTO: Create Room View Controller
}

**@IBAction** when "Done" button is pressed {

    if all text fields, descriptions, address and pictures are uploaded {
        if this is the first room uploaded {
            save room details to database
            GOTO: Schedule Inspection View Controller
        }
        if this is the second or more room uploaded {
            if this room is not in the same house (based on address) {
                save room details to database
                GOTO: Schedule Inspection View Controller
            }
            if this room is in the same house (based on address) {
                save room details to database
                GOTO: My Rooms View Controller
            }
        }
    }
    if any of these fields are missing {
        Error Message: "Please fill in all the fields before proceeding."
        DISMISS: *OK*
    }
}

### Room/ Home Inspection to verify space

**@IBAction** when host clicks on an available time and date {

    GOTO: Confirm Inspection View Controller
    A person with a verified ID comes at scheduled time to inspect the house and room for safety
    the room that host added will show "pending" {
        The room listing will be slightly faded (like when something is loading up) until it is approved 
        This room listing will be under My Rooms tab.
    }
    After inspection, inspector will approve room listing and the listing will be available publicly
}

### Host goes to My Rooms View Controller 

After adding a room and/ or scheduling a time for inspection {

    query database for new rooms added
    update the listing on the top with the last room that host added
}

**@IBAction** when host taps on any of the rooms {

    room goes to edit mode, so user can make any changes to description, price, pictures
}

**@IBAction** when host presses the "Save" button {

    updates the new information to database
    if any of the textfeilds are empty {
        Error Message: "Please enter in all information before proceeding."
    }
}

## Host goes to Settings

### Host goes to My Profile
**@IBAction** when "My Profile" button is pressed {

    GOTO: My Profile View Controller
    Show User's Photo, Bio, Name, Phone number, email
    Button at the Bottom: "Verify my profile" if user did not verify
    if verified, it will show on user's profile when booking so host has more trust
}

### Host goes to My Bank and Payment Details to update this information

**@IBAction** when "Add Card" button is pressed {

    add a credit/ debit card 
    verify the card and add it to payments list
    Card is added to database
}

**@IBAction** when "Add Bank Details" button is pressed {

    add a bank account number 
    verify the account and add it to list
    bank account information is added to database
}

**@IBAction** when "Add Cash to Account" button is pressed {

    ask host how much money to add 
    suggested: $20, $40, $60, custom (absolute value)
    Amount value is added to database, this balance is in sync with user profile
}

**@IBAction** when "Add coupon code" button is pressed {

    if coupon code = valid {
        add corresponding cash value to user's account balance
    }
    if coupon code != valid {
        Error message: "Please enter in a valid coupon code"
        DISMISS: "OK" Button
    }
}

# Using the bot

## General

After signing up: 

    bot introduces itself to user: "Hello there, Sashank! I'm Mac, your personal assistant. Welcome to The RoomApp!
    bot says: "I'm here to help you simplify your experience when using this service."
    bot says: "Some of the things I can do is give reminders about your room reservations, guide you from booking the right space, navigating to the space you've reserved, and making your checkin/ checkout easier, and everything else in between!"
    bot says: "You can find me in different chatboxes in different hosts to make your interactions with hosts as seamless as possible
    bot says: "Oh, and one last thing. If you type "help" when you DM me or turn the 'bot' mode on in any of the chatboxes, you can see the list of things I can help you with and how to ask me those questions."
    bot says: "I hope you have a great time using The RoomApp!"

There will be a bot for the user and host in every chat box. Whatever they ask the bot and the response they get can only be seen by them. 

There is also a separate chatbox for the bot for the user/ host to DM for tutorials and help (This also works in the user- host chat boxes, but they get deleted after 24 hours)

Bots can send messages and alerts for user and host. Examples of alerts are user booking a room, reminders for reservation time left, emergency/ security situations, etc. Certain messages can also be set as alerts, and some alerts can be set as messages.

## User- specific

When user confirms a reservation for a space

    Bot says these in the chat box with host of that space (Will get in-app notifications as well)
    bot says: "Your reservation for this room on [day] from [start-time] to [end-time] is confirmed!"
    bot says: "Here's the address: [address]"
        Note: address will also be shown under the room listing in Reserved Rooms View Controller    

When the user checks in through the main door

    bot says: "Go straight past the living room and turn right in the hallway. Your room should be on the left."
    Note: User can check in to their room at the reservation start time, and has ~ 5 minutes (depending on size and layout of the house) to check into the room. 
          User can check in through the main entrance ~ 5 minutes before start time
        bot says: "your room check in is at 1:00 pm. You can check in from the main door starting from 5 mimutes prior."

    if it is more than 5 minutes since user checked in through main door but has to check in through another door(s) {
        It seems like you haven't checked in yet! Would you like the host to help you out?
            Options -> Yes, please -- No, I found my space
        if user clicks on "no, I found my space" but has not check in after 5 minutes {
            bot notifies the host to beware and keep track of any suspicious activities.
            bot says "I've informed the host as you haven't checked in yet"
        }
        if user does not respond within 5 minutes {
            bot notifies the host to beware and keep track of any suspicious activities.
            bot says "I've informed the host as you haven't checked in yet"
        }
    }

After the user checks in through the room door

    bot says: "You've checked in! You have a reservation until 4:00 pm. I'll notify you 15 minutes and 5 minutes before the reservation ends. Let me know anytime if you want to extend your reservation."
    first time user ever checks in: "You can change the timer and frequency of the reminders by asking me directly through the chat or settings. However, the 5 minute reminder is defaulted for everyone and cannot be changed."

Before the user checks out

    At the 15 minute mark:
    
    if there is no other reservation at end time (in this example, 4:00 pm) {
        bot says: "You have 15 minutes before your reservation ends! Would you like to extend it for more time?"
            Options -> Yes -- No
        Note: the user has until the end of their current reservation to book
        if user presses yes {
            if there is no other reservation at that time{
                bot looks at next reserved time. 
                if there is a reservation in less than an hour before current user's reservation end time {
                    bot says: "You would only be able to reserve it for 30 more minutes since there is a reservation at 4:30. You will only be charged for 30 minutes, so your total will be $15.45. 
                                Would you like to proceed with this transaction?"
                }
                bot says: "How many hours would to like to reserve it for?"
                User adds the number of hours
                if there is another reservation within a couple hours and user's extension overlaps with that {
                    bot says: "You would only be able to reserve it for 2 hours and 30 minutes more since there is a reservation at 6:30 pm. You will only be charged for 2 hours and 30 minutes, so your total will be $87.42.
                                Would you like to proceed with this transaction?"
                }
                bot says: "The total would be $99.91. Would you like to continue?"
                    Options -> Yes -- No
                if user presses yes {
                    bot says: "Great! You have extended your reservation for three more hours."
                }
            }
        }
        if another user reserves the same room before current user extends {
            bot says: "It looks like this room has been reserved at 4:00 pm. You only have 10 minutes left."
        }
    }
    if there is a reservation at this time {
        bot says: "It looks like this room is booked for 4:00 pm. You only have 15 minutes before your reservation ends"
    }

    At the 5 minute mark: 
    bot says: "You only have 5 minutes left! make sure you take all your belongings with you before leaving!"

Note: User has to check out of the room by the reservation end time, and has ~ 5 minutes (depending on size and layout of the house) to check out of the main entrance

After user checks out from the room

    bot says: "To get to the main door, Go to the entrance of the hallway, go past the living room, and turn left."

    if it is more than 5 minutes since user checked out from room but has to check out through main door {
        It seems like you haven't checked out from the main door yet! Would you like the host to help you out?
            Options -> Yes, please -- No, I found the main entrance
        if user clicks on "no, I found the main entrance" but has not check in after 5 minutes {
            bot notifies the host to beware and keep track of any suspicious activities.
            bot says "I've informed the host as you haven't checked out yet"
        }
        if user does not respond within 5 minutes {
            bot notifies the host to beware and keep track of any suspicious activities.
            bot says "I've informed the host as you haven't checked out yet"
        }
    }

If user hasn't check out by the allotted time

    bot says: "Uh- oh, it looks like you haven't checked out by the allotted time! You will be charged $2 (depending on location, price of room, demand for immediate reservation) for every extra minute you spend until you check out."

After user checks out from the main door

    bot says: "Thank you for reserving this room! Please tap here to rate the room and the host's service."
    (This screen will also pop up after checking out)
    User has 2 hours to respond to this rating. If not, this message will disappear.

If user books a space on any of its blackout days

    bot says: "I'm sorry, this space isn't available during this time/ day/ week. Let me know if you want to reserve this space on a different time."

## Host- specific

After host does a background check and creates an account

    Bot introduces itself again, but lists out tasks it can do in a host account

After posting a room

    Bot will ask: 
        What amenities are there (restroom, shower, printer, monitor, whiteboard, etc.)?
        How much time do you want to give the user to go from main door to checking in at the front door (minimum is 5 minutes)
        What directions to give so user can navigate to the room from main door?
        Will you allow the user to extend their room reservation if no other user has reserved for the time right after (up until the next reservation)?

When user books a space

    bot says: "User book your space on Wednesday, April 5th 2020 from 1:00 pm to 4:00 pm!"
    If user cancels the reservation
        bot says: "User cancelled his/ her reservation of your space on Wednesday, April 5th 2020 from 1:00 pm to 4:00 pm!"

Before user checks in

    If any user actions is flagged as suspicious activity
        bot says: "it has been more than 5 minutes since User checked in from the main door, but not into the allotted room. The motion sensors are now activated and will update any suspicious movements.
    If user wanted help from the host for navigating
        bot says: "It has been more than 5 minutes since User checked in from the main door, but not into the allotted room. He/ she wants you to help them to get to their space.
    Option: host can set the bot to give updates every time it detects a noticeable user action throughout the reservation time slot
        bot says: "User just checked in through the main door/ room door." "User opened the room door 20 minutes into the reservation."
        User can also turn on/ off motion sensors/ other security equipment using the bot.
            bot says: "I just turned on the motion sensors"

Before checking out

    If user extends their reservation time
        bot says: "User just extended their time by 3 hours, so you just earned an extra $78!"

If user checks out late 

    bot says: "User has stayed past his allotted reservation time! If there is another reservation right after, make sure you inform the next user as soon as possible."
    After user checks out late:     
        Tell how much fine they spent and how many extra minutes they stayed
        bot says: "User has stayed for 5 extra minutes and payed $10 as fine."

After user checks out

    If user gives any tip
        bot says: "User just gave you a tip of $10!"
    If user gives any comments
        bot says: "User just commented on your room/ host service!"
    After 24 hours are over
        chats are deleted by default, user can hold chats by pressing and holding on a message.
