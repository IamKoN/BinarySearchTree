--Binary Search Tree Lab
--A Option
--Nathan Robinson

generic
   type key is private;
   type tree_rec is private;

   -- Is thekey eqaul to the key of rec?
   with function "=" (thekey : in key; rec : in tree_rec) return boolean;
   -- Is thekey less than the key of rec?
   with function "<" (thekey : in key; rec : tree_rec) return boolean;
   -- Is thekey greater than the key of rec?
   with function ">" (thekey : in key ; rec : tree_rec) return boolean;

package BST is
   subtype string10 is string (1 .. 10);

   -- Points to a node in a binary search tree
   --type BinarySearchTreePoint is limited private;
   type BSTptr is limited private;

   procedure init;
   
   --Iterative: Insert node in sorted order
   --procedure InsertBST(Root:in out BinarySearchTreePoint; custName: in String10; custPhone: String10 );
   procedure insert (name : string10; phone : string10);

   --DeleteRandomNode(DeletePoint: in BinarySearchTreePoint):
   procedure delete (name : string10);

   --Iterative: Binary Search
   --procedure FindIterative(Root:in BinarySearchTreePoint; CustomerName:in String10; CustomerPoint:out BinarySearchTreePoint);
   function find_iterative (name : string10) return BSTptr;

   --Recursive: Binary      
   --procedure FindRecursive(Root: in BinarySearchTreePoint; CustomerName:in String10; CustomerPoint:out BinarySearchTreePoint);
   function find_recursive (name : string10) return BSTptr;

   --Iterative:
   procedure inorder (name : string10);

   --Recursive:
   procedure preorder (point : in BSTptr);

   --Iterative:
   procedure postorder_iter (point : in BSTptr);

   --Recrsive:
   procedure postorder_recurs (point : in BSTptr);

   --Recursive:
   procedure reverse_in (point : BSTptr);

   function inorder_succ (point : in BSTptr) return BSTptr;
   function inorder_pred (point : in BSTptr) return BSTptr;
   function cust_name (point : in BSTptr) return string10;
   function cust_phone (point : in BSTptr) return string10;
   function root return BSTptr;
   procedure print_info (point : in BSTptr);
   procedure free_all;


private
   type node;
   type customer is record
      name  : string10;
      phone : string10;
   end record;

   type BSTptr is access node;
   type node is record
      llink, rlink : BSTptr;
       -- True indicates pointer to lower level, False a thread.
      ltag, rtag   : boolean;      -- true = +; false = -
      info         : customer; -- info: tree_rec
   end record;
end BST;
