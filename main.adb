with ada.text_io; use ada.text_io;
with BST;

procedure main is
   type string10 is new string (1 .. 10);
   type customer is record
      name  : string10;
      phone : string10;
   end record;

   function "<" (thekey : in string10; rec : customer) return boolean is
   begin
      if thekey < rec.name then
         return true;
      else
         return false;
      end if;
   end;

   function ">" (thekey : in string10; rec : customer) return boolean is
   begin
      if thekey > rec.name then
         return true;
      else
         return false;
      end if;
   end;

   function "=" (thekey : in string10; rec : customer) return boolean is
   begin
      if thekey = rec.name then
         return true;
      else
         return false;
      end if;
   end;

   package newBST is new BST(string10, customer, "<", ">", "=");
   --package MySearchTree is new BinarySearchTree( Name, Customer, <, >, =);
begin
   put_line ("~~~'C' Option Transactions~~~"); New_Line;

   newBST.insert("Nkwantal  ", "295-1492  ");
   newBST.insert("Ortiz     ", "291-1864  ");
   newBST.insert("Glosson   ", "295-1601  ");
   newBST.insert("Yang      ", "293-6122  ");
   newBST.insert("Parker    ", "295-1882  ");
   newBST.insert("Kresta    ", "291-7890  ");
   newBST.insert("Rock      ", "294-8075  ");
   newBST.insert("Bell      ", "584-3622  ");

   put_line(newBST.cust_phone(newBST.find_iterative ("Kresta    ")));
   put_line(newBST.cust_phone(newBST.find_recursive ("Kresta    ")));
   put_line(newBST.cust_phone(newBST.find_iterative ("Acevedo   ")));
   put_line(newBST.cust_phone(newBST.find_recursive ("Acevedo   ")));

   new_line;
   put_line ("In Order Traversal: ");
   newBST.inorder("Parker    "); new_line;

   newBST.insert("Pevin     ", "294-1568  ");--Devin
   newBST.insert("Norah     ", "294-1882  ");--Morah
   newBST.insert("Zembo     ", "295-6622  ");

   new_line;
   put_line ("In Order Traversal: ");
   newBST.inorder(newBST.cust_name(newBST.root)); new_line;

   put_line ("~~~'B' Option Transactions~~~"); New_Line;

   newBST.delete("Kresta    ");
   newBST.delete("Najar     ");
   newBST.delete("Glosson   ");


   newBST.insert("Novak     ", "294-1666  ");
   newBST.insert("Gonzales  ", "295-1882  ");

   new_line;
   put_line ("In Order Traversal: ");
   newBST.inorder(newBST.cust_name(newBST.root));
   new_line;

   new_line;
   put_line ("Reverse In Order Traversal: ");
   newBST.reverse_in(newBST.root);
   new_line;

   put_line ("Pre Order Traversal: ");
   newBST.preorder(newBST.root);
   new_line;

   put_line ("~~~'A' Option Transactions~~~"); New_Line;

   new_line;
   put_line ("Iterative  Post Order Traversal: ");
   newBST.postorder_iter(newBST.root);
   new_line;

   new_line;
   put_line ("Recursive Post Order Traversal: ");
   newBST.postorder_recurs(newBST.root);
   new_line;

   newBST.free_all;

   put_line ("Program terminated");
   new_line;
end main;
