# Test table

Test case | Result 
:- | -
Navigation bar links all point to their respective pages | Pass
Privacy policy page in footer links to /privacy | Pass
Bookings form can be submitted | Pass
Bookings form cannot be submitted if any fields are left empty | Pass
Help button can be clicked on any page to open help menu | Fail
Bookings form field presences are validated on serverside | Pass
Bookings form field types are validated on serverside | Pass
Form responses save to database | Pass

The help button issue was fixed by adding the event handler after each page navigation rather than only on page load, as previously the button was recreated, causing any event handlers to disappear from it.
