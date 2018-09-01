
r1 = "OMNIKEY CardMan 5x21 0";
r2 = "SCM Microsystems Inc. SDI011G Contactless Reader 0";
reader1(r1);
reader2(r2);

reset(r1);
reset(r2);
send("00a4040000","9000",r1);
send("00a4040000","9000",r2);
send("00a4040000","9000",r1);

reset(r2);
send("00a4040000","9000",r2);

reset(r1);
send("00a4040000","9000",r1);

