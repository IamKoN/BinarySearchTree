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
   type tree_pnt is limited private;

   procedure initialize;
   --Iterative: Insert node in sorted order
   procedure insert (name : string10; phone : string10);

   --DeleteRandomNode(DeletePoint: in BinarySearchTreePoint):
   procedure delete (name : string10);

   --Iterative: Binary Search
   function find_iterative (name : string10) return tree_pnt;

   --Recursive: Binary Search
   function find_recursive (name : string10) return tree_pnt;

   --Iterative:
   procedure inorder (name : string10);

   --Recursive:
   procedure preorder (point : in tree_pnt);

   --Iterative:
   procedure postorder_iter (point : in tree_pnt);

   --Recrsive:
   procedure postorder_recurs (point : in tree_pnt);

   --Recursive:
   procedure reverse_in (point : tree_pnt);


   function inorder_succ (point : in tree_pnt) return tree_pnt;
   function inorder_pred (point : in tree_pnt) return tree_pnt;
   function cust_name (point : in tree_pnt) return string10;
   function cust_phone (point : in tree_pnt) return string10;
   function root return tree_pnt;
   procedure print_info (point : in tree_pnt);
   procedure free_all;

   --procedure InsertBST(Root:in out BinarySearchTreePoint; custName: in String10; custPhone: String10 );
   --procedure FindIterative(Root:in BinarySearchTreePoint; CustomerName:in String10; CustomerPoint:out BinarySearchTreePoint);
   --procedure FindRecursive(Root: in BinarySearchTreePoint; CustomerName:in String10; CustomerPoint:out BinarySearchTreePoint);

private
   type node;
   type customer is record
      name  : string10;
      phone : string10;
   end record;

   type tree_pnt is access node;
   type node is record
      llink, rlink : tree_pnt;
       -- True indicates pointer to lower level, False a thread.
      ltag, rtag   : boolean;      -- true = +; false = -
      info         : customer; -- info: tree_rec
   end record;
end BST;
