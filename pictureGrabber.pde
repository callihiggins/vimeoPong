class VimeoGrabber {
  //variables
  String userPhoto = " ";
  String userID = " ";
  String user = " ";
  String url = "xmldocument.xml"; 



  //get photo URL

  String getuserPhoto() {

    return userPhoto;
  }

  String getUser() {

    return userID;
  }

  VimeoGrabber() {
  }
  /* void requestUser(String email) {
    //Get all the HTML/XML source code into an array of strings
    //EVENTUALLY PUT IN A PROXY!!

    String url ="http://vimeo.com/api/rest/v2?method=vimeo.people.findByEmail&email=" + email;
    println(url);
    String[] lines = loadStrings(url);

    //turn array into one long string
    String feed = join(lines, " ");
    println(feed);
    // Searching for thumbnail link
    String lookfor =" <username>";
    String end = "</username>";
    userID = giveMeTextBetween(feed, lookfor, end);
    println(userID);
  }*/


  //Make the XML request
  void requestImage(String tempuser) {
   user = tempuser;
   println(user);
   //Get all the HTML/XML source code into an array of strings
   //EVENTUALLY PUT IN A PROXY!!
   
   String url ="http://vimeo.com/api/v2/" + user + "/info.xml";
   println(url);
   String[] lines = loadStrings(url);
   
   //turn array into one long string
   String feed = join(lines, " ");
   
   // Searching for thumbnail link
   String lookfor ="<portrait_large>";
   String end = "</portrait_large>";
   userPhoto = giveMeTextBetween(feed,lookfor,end);
   
   }

  // A function that returns a substring between two substrings
  String giveMeTextBetween(String s, String before, String after) {
    String found = "";
    int start = s.indexOf(before);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after, start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start, end);    // Return the text in between
  }
}






