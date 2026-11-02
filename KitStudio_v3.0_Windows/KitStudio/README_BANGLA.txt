MDA-8086 Kit Studio 3.0 — ব্যবহারের নিয়ম
==========================================

এটা একটাই প্রোগ্রাম: কোড লেখা, Assemble করা, kit ছাড়াই simulator-এ চালিয়ে দেখা, আর
MDA-8086 kit-এ পাঠিয়ে চালানো — সব এক জায়গায়। DOSBox, emu8086, TASM কিছুই লাগে না।
- Windows: XP, 7, 8, 10, 11 — 32 আর 64 bit (KitStudio.exe)
- Linux: 64 আর 32 bit, Intel বা AMD প্রসেসর (Ubuntu, Mint, Debian, Fedora, Arch ...;
  মোটামুটি 2014-এর পরের যেকোনো Linux)

3.0-এ নতুন: Simulator
- বাম পাশে কোড, ডান পাশে পুরো kit: dot matrix 8x8, 7-segment, ৪টা LED (PB0-PB3),
  LCD 16x2, register, flag আর দুই 8255-এর port — প্রোগ্রাম চলার সময় সব একসাথে দেখা যায়।
- Run (F6): kit ছাড়াই প্রোগ্রাম চালায়, আসল kit-এর গতিতে।
  Step (F8): একবারে একটা instruction চালায়; এরপর যে লাইন চলবে সেটা editor-এ দাগানো থাকে
  (Linux-এ হলুদ, Windows-এ select করা)।
  Pause (F9): থামায়। Reset: আবার 1000H থেকে শুরু।
  Speed: 1x = আসল kit। বামে টানলে slow motion — কলামগুলো কীভাবে একটা একটা করে জ্বলে, দেখা যায়।
- রং সাদা (light)। প্রতিটা LED-এর চারপাশে স্পষ্ট বৃত্ত, তাই নিভে থাকা LED-ও বোঝা যায়।
- ছোট স্ক্রিনে (১২০০ pixel-এর কম চওড়া) simulator emu8086-এর মত নিজের আলাদা উইন্ডোতে খোলে।
  Simulator > Separate window দিয়ে যেকোনো সময় আলাদা বা পাশাপাশি করা যায়।
  আলাদা উইন্ডোটা বন্ধ করলে simulator আবার মূল উইন্ডোর ডান পাশে ফিরে আসে।
- দুটো Template আর সব Example simulator-এ চলে।
- প্রোগ্রাম থেমে গেলে কারণও দেখায়, যেমন "INT 21H is DOS - the kit has no DOS" বা
  "Ran past the end of the program (end with a JMP loop)"।

2.0-এ যা এসেছিল: Templates মেনু (Template 1 - Short form, Template 2 - Book style),
প্রোগ্রামের ভেতরেই ৪টা Example (7-segment 0-9, three-colour rows, letter A, A scrolling),
আর Linux ভার্সন।


১. Windows-এ চালানো
-------------------
- zip ফাইলটা নামানোর পর: right-click > Properties > নিচে "Unblock" টিক দাও > OK।
  তারপর right-click > Extract All। এভাবে করলে সাধারণত কোনো সতর্কবার্তা আসে না।
- Unblock না করলে প্রথমবার "Windows protected your PC" আসতে পারে:
  "More info" চাপো > "Run anyway"। একবার করলেই হবে।
  (প্রোগ্রামটা টাকা দিয়ে কেনা certificate দিয়ে sign করা না, তাই Windows এটা চেনে না।
   এতে ক্ষতিকর কিছু নেই; পুরো source code আলাদা zip-এ দেওয়া আছে।)
- KitStudio.exe যেকোনো ফোল্ডার বা pendrive থেকে চালানো যায়। আর কোনো ফাইল লাগে না।


২. Linux-এ চালানো
-----------------
- KitStudio_v3.0_Linux.tar.gz extract করো (right-click > Extract Here), বা terminal-এ:
      tar xzf KitStudio_v3.0_Linux.tar.gz
- সরাসরি চালাতে: KitStudio-3.0-linux ফোল্ডারে ঢুকে terminal-এ  ./kitstudio
  64-bit না 32-bit, সেটা ./kitstudio নিজেই বুঝে ঠিক প্রোগ্রামটা চালায়।
- Menu-তে রাখতে (একবারই):  sh install.sh
  (root password লাগে না। সরাতে চাইলে: sh install.sh --remove)
  আগে 2.0 install করা থাকলে নতুন ফোল্ডার থেকে আবার  sh install.sh  চালাও।
- Kit-এর serial port ব্যবহার করতে একবার এটা চালাও, তারপর log out করে আবার log in করো:
      sudo usermod -aG dialout $USER
  (Arch/Manjaro-তে dialout-এর জায়গায় uucp। প্রোগ্রামও দরকার হলে এটা বলে দেয়।)
  শুধু simulator ব্যবহার করলে এটা লাগে না।
- GTK 3 লাগে। প্রায় সব Linux desktop-এ আগে থেকেই থাকে; না থাকলে ./kitstudio বলে দেবে
  কোন command দিয়ে install করতে হবে।


৩. Kit লাগানো
-------------
- Kit পিসির সাথে কথা বলে RS-232 serial দিয়ে: 9-pin (2 সারি) cable।
- পিসিতে COM port থাকলে (9 pin, 2 সারি): সেখানে লাগাও।
  সাবধান: VGA মনিটর port দেখতে একই রকম কিন্তু 15 pin, 3 সারি — ওটা না।
- ল্যাপটপ বা COM port ছাড়া পিসি: "USB to RS232 (DB9) serial adapter" লাগবে।
  Windows: FTDI বা CH340 chip-এর adapter ভালো চলে; সস্তা PL2303 নকল Windows 10/11-এ
  প্রায়ই চলে না। adapter লাগালে সেটা COM3/COM4 ইত্যাদি হিসেবে আসে।
  Linux: আলাদা driver লাগে না; adapter /dev/ttyUSB0 (বা /dev/ttyACM0) হিসেবে আসে।
  প্রোগ্রাম নিজেই port খুঁজে নেয়।
- HDMI, VGA বা ডিসপ্লে adapter দিয়ে kit চলবে না — ওগুলো শুধু ছবি পাঠায়, data না।
- Kit-এ SELECT MODE switch = PC।


৪. Simulator-এ চালানো (kit ছাড়া)
--------------------------------
- কোড লেখো, বা Templates / Examples মেনু থেকে নাও, তারপর F6 (Run) বা F8 (Step)।
  Simulator নিজেই Assemble করে নেয়; ভুল থাকলে নিচের output-এ লাল লেখায় দেখায়, F7-এর মতই।
- উপরের রঙিন লেবেল: NO PROGRAM, READY (চালানোর জন্য তৈরি), RUNNING, PAUSED,
  STOPPED (পাশে কারণ লেখা থাকে)।
- Step (F8) চাপতে থাকলে register, flag আর port-এর মান বদলায়; "Next: line 12 ..." দেখায়
  এরপর কোন লাইন চলবে।
- Dot matrix: সবুজ = 1AH, লাল = 18H, দুটো একসাথে = হলুদ। নিচে লেখা আছে কোন bit কোন
  সারি/কলাম।
- 8255 PORTS অংশে প্রতিটা port-এ শেষ যে মান পাঠানো হয়েছে (hex আর binary)।
  "CR -- not set up" লাল থাকলে মানে MOV AL,80H / OUT 1EH,AL (বা OUT 1FH,AL) দেওয়া হয়নি —
  আসল kit-এ তখন কিছু জ্বলবে না।
- কোড বদলালে আবার F6 বা F8 চাপো: নতুন কোডটাই লোড হয়।
- Port-এর হিসাব আমাদের ল্যাবের আসল kit-এ চালিয়ে মেলানো (dot matrix: 18H লাল, 1AH সবুজ,
  কলাম bit 0 = বাম)। GitHub-এর web simulator-এ এগুলো উল্টো, তাই ওখানে যা ঠিক দেখায়,
  আসল kit-এ সেটা ভুল হতে পারে।
- LED (PB0-PB3, port 1BH): 1 দিলে জ্বলে ধরা হয়েছে (web simulator থেকে নেওয়া; আসল kit-এ
  এখনো মিলিয়ে দেখা হয়নি)।
- Simulator kit-এর model। শেষ কথা আসল kit-এ চালিয়ে দেখা।


৫. Kit-এ প্রোগ্রাম চালানো
------------------------
- কোড লেখো, বা Templates মেনু থেকে শুরু করো, বা Examples মেনু থেকে একটা প্রোগ্রাম নাও,
  বা File > Open। Example খুললে সেটা একটা কপি হিসেবে খোলে; নিজের মত রাখতে File > Save As।
- F7 (Assemble): ভুল থাকলে লাল লেখায় লাইন নম্বর দেখায়, যেমন
      MYPROG.ASM(12) : Error A2209: Syntax error: MOVX
  ওই লাল লাইনে (বা বেগুনি Hint লাইনে) double-click করলে editor-এ সেই লাইনে চলে যাবে।
  ঠিক থাকলে machine code (address: bytes) দেখায় — keypad দিয়ে দেওয়া বা
  lab report-এর জন্য কাজে লাগে। ফাইল save করা থাকলে পাশে NAME.ABS-ও বানায়।
  তার নিচে "Kit check": dot matrix-এর ছবি (# = সবুজ, R = লাল, @ = হলুদ, . = নিভে আছে)
  আর 7-segment-এর সংখ্যাগুলো। কমলা রঙের "!" লাইন মানে সতর্কতা।
- F5 (Run on Kit): Assemble করে, kit খুঁজে, প্রোগ্রাম পাঠিয়ে (L) চালু করে (G 0000:1000)।
- Kit উত্তর না দিলে প্রোগ্রাম বলবে "press RESET" — তখন kit-এর RESET চাপো
  (৬০ সেকেন্ড অপেক্ষা করে)। একটা প্রোগ্রাম চলার সময় নতুনটা পাঠাতে হলেও RESET লাগে।
- Stop (Esc): অপেক্ষা বাতিল।
- Port: "Auto" রাখলে সব port-এ নিজে খোঁজে। চাইলে নির্দিষ্ট port বেছে দিতে পারো।
  নতুন adapter লাগালে Refresh চাপো।
- নিচের বক্সে kit-এর monitor command লিখে Enter:
      D 0000:1000 40     (memory দেখা)
      R                  (register দেখা)
- Kit > Send .ABS file: আগে বানানো .ABS পাঠানো (যেমন ল্যাবের নমুনা FND.ABS)।
  .ABS বা .ASM ফাইল টেনে প্রোগ্রামের উইন্ডোতে ছাড়লেও হয়।


৬. Kit-এর প্রোগ্রাম লেখার নিয়ম
-----------------------------
- Kit প্রোগ্রাম চালায় 0000:1000 থেকে: প্রথম instruction-এর আগে ORG 1000H দাও।
  (দুটো Template-এই এটা দেওয়া আছে।)
- INT 21H (DOS) kit-এ নেই — kit-এর জিনিস চালাতে OUT ব্যবহার করো।
  Kit-এর প্রোগ্রাম সাধারণত JMP দিয়ে চিরকাল ঘোরে; থামাতে চাইলে INT 3।
- আগে 8255 চালু করো: MOV AL,80H তারপর OUT 1EH,AL (dot matrix) বা OUT 1FH,AL (7-segment, LED)।
- Dot matrix: 18H লাল, 1AH সবুজ (সারি), 1CH কলাম। সারিতে 0 দিলে LED জ্বলে।
  কলাম bit 0 = বাম দিক, সারি bit 7 = উপরে। লাল আর সবুজ একসাথে = হলুদ।
- 7-segment: 19H, 0 দিলে segment জ্বলে (0 = C0H, 1 = F9H, ... 9 = 90H)।
- LED: 1BH (PB0-PB3)। LCD: 00H command, 04H data, 02H status।


৭. সমস্যা হলে
-------------
- "No COM port found" / "No serial port found": cable/adapter লাগানো নেই, বা adapter-এর
  driver নেই (Windows)।
- "COMx is busy" / "is busy": PuTTY, minicom বা অন্য কোনো প্রোগ্রাম port খুলে রেখেছে —
  সেটা বন্ধ করো।
- Linux-এ "no permission": উপরের  sudo usermod -aG dialout $USER  তারপর log out/log in।
- "Kit not found": kit-এর power, switch PC, cable ঠিক আছে কিনা দেখো;
  অপেক্ষার সময় RESET চাপো।
- Simulator খুব ছোট দেখালে: Simulator > Separate window, তারপর ওই উইন্ডো বড় করো।
- Antivirus প্রোগ্রামটা আটকালে "Allow"/"Restore" দাও।
- অন্য কিছু অদ্ভুত হলে: Help > Kit log খুলে পুরো লেখাটা কপি করে পাঠাও।
