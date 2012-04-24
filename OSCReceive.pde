void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */

  if (theOscMessage.checkAddrPattern("/pot")==true) {

    pot1 = theOscMessage.get(0).intValue();  
    pot2 = theOscMessage.get(1).intValue();  
//    print("### received an osc message ");
//    println(" values: "+pot1+ ", "+pot2);
    return;
  }
}
