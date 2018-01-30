--Binary Search Tree Lab
--A Option
--Nathan Robinson


with ada.text_io; use ada.text_io;
with Ada.Unchecked_Deallocation;
with stack;

package body BST is
   knt        : integer := 1;
   head       : BSTptr;
   recurs_pnt : BSTptr;

   procedure free is new ada.unchecked_deallocation (node, BSTptr);

   procedure init is begin
      head := new node;
      head.llink := head;
      head.rlink := head;
      head.ltag  := false;
      head.rtag  := true;
      recurs_pnt := head.llink;
   end init;

   procedure insert(name: string10; phone: string10) is
      p, q : BSTptr;
   begin
      p := new node;
      p.info.name  := name;
      p.info.phone := phone;

      -- first node
      if "=" (head.llink, head) then
         p.llink := head;
         p.rlink := head;
         p.ltag  := false;
         p.rtag  := false;
         head.llink := p;
         head.ltag  := true;
         --knt := knt + 1;

         new_line; put (name); put (" inserted"); new_line;
      else
         --knt := knt + 1;
         new_line; put (name); put (" inserted"); new_line;
         q := head.llink;

         loop
            if "<" (name, q.info.name) then
               if q.ltag /= false then q := q.llink;
               else
                  p.llink := q.llink;
                  p.ltag  := q.ltag;
                  q.llink := p;
                  q.ltag := true;
                  p.rlink := q;
                  p.rtag := false;
                  exit;
               end if;
            elsif ">" (name, q.info.name) or "=" (name, q.info.name) then
               if q.rtag /= false then q := q.rlink;
               else
                  p.rlink := q.rlink;
                  p.rtag  := q.rtag;
                  q.rlink := p;
                  q.rtag := true;
                  p.llink := q;
                  p.ltag := false;
                  exit;
               end if;
            end if;
         end loop;
      end if;
   knt := knt + 1;
   end insert;

   procedure delete (name: string10) is
      q, p, t, v : BSTptr;
   begin
      q := find_iterative (name);
      v := head.llink;

      -- Blank phone number implies not found
      if q.info.phone = "          " then return;
      end if;

      t := q;
      p := q;

      if p /= root then
         while p.llink /= q and p.rlink /= q loop
            if p = head then p := head.llink;
            else p := inorder_succ (p);
            end if;
         end loop;
      else p := head;
      end if;

      if t.rtag = false then q := t.llink;
         if q = head then q := head.llink;
         end if;
      else
         if t.ltag = false then q := t.rlink;
            if q = head then q := head.llink;
            end if;
         end if;
      end if;

      if p = head then head.llink := q;
      else
         if p.llink = t then p.llink := q; p.ltag  := t.ltag;
         else                p.rlink := q; p.rtag  := t.rtag;
         end if;
      end if;

      free(t);
      knt := knt - 1;
      put(name); put("deleted"); new_line;
   end delete;

   function find_iterative (name : string10) return BSTptr is
      p, blank : BSTptr;
      cust : customer;
   begin
      cust.name := name; cust.phone := "          ";
      p := head.llink;

      loop
         if "<" (name, p.info.name) then
            if p.ltag /= false then
               p := p.llink;
            else
               new_line; put (name); put ("not found");
               p := new node; p.info := cust; return p;
            end if;
         elsif ">" (name, p.info.name) then
            if p.rtag /= false then
               p := p.rlink;
            else
               new_line; put (name); put ("not found");
               p := new node; p.info := cust; return p;
            end if;
         elsif "=" (name, p.info.name) then return p;
         else
            new_line; put (name); put ("not found");
            p := new node; p.info := cust; return p;
         end if;
      end loop;
   end find_iterative;

   function find_recursive (name : string10) return BSTptr is
      p : BSTptr;
      cust : customer;
   begin
      cust.name := name;
      cust.phone := "          ";

      if recurs_pnt = head then recurs_pnt := head.llink;
      end if;
      loop
         if "<" (name, recurs_pnt.info.name) then
            if recurs_pnt.ltag /= false then
               recurs_pnt := recurs_pnt.llink;
               return find_recursive (name);
            else
               new_line; put (name); put ("not found");
               p := new node; p.info := cust; return p;
            end if;
         elsif ">" (name, recurs_pnt.info.name) then
            if recurs_pnt.rtag /= false then
               recurs_pnt := recurs_pnt.rlink;
               return find_recursive (name);
            else
               new_line; put (name); put ("not found");
               p := new node; p.info := cust; return p;
            end if;
         else
            return recurs_pnt;
         end if;
      end loop;
   end find_recursive;

   procedure inorder (name : string10) is
      node : BSTptr;
   begin
      node := find_iterative (name);

      -- Go left as far as possible
      while node.ltag = true loop
         node := node.llink;
      end loop;

      for i in 1 .. knt - 1 loop
         print_info (node);
         node := inorder_succ (node);
      end loop;
   end inorder;

   procedure preorder (point : in BSTptr) is
      p : BSTptr;
      package stk is new stack (20, BSTptr);
   begin
      p := point;

      loop
         -- Visit
         if p /= head then
            print_info (p);
            stk.push (p);
         end if;

         if p.ltag = true then
            exit when p.llink = point;
            p := p.llink;
         else
            while p.rtag = false loop
               p := p.rlink;
            end loop;
            if p.rlink = point then
               exit;
            end if;
            p := p.rlink;
         end if;
      end loop;
   end preorder;

   procedure postorder_iter (point : in BSTptr) is
      p : BSTptr;
      type stk_rec is record
         pnt : BSTptr;
         num : natural range 0 .. 1;
      end record;
      rec : stk_rec;
      d   : natural range 0 .. 1;
      i : natural := 0;
      package stk is new stack (20, stk_rec);
   begin
      p := point;
      loop
         if p /= null then
            rec.pnt := p;
            rec.num := 0;
            stk.push(rec);

            if p.ltag = false then
               p := null;
            else
               p := p.llink;
            end if;
         else
            exit when stk.is_empty = true;
            rec := stk.pop;
            p   := rec.pnt;
            d   := rec.num;

            if d = 0 then
               rec.pnt := p;
               rec.num := 1;
               stk.push(rec);

               if p.rtag = false then
                  p := null;
               else
                  p := p.rlink;
               end if;
            else
               loop
                  print_info (p);
                  i := i + 1;

                  if i = knt - 1 then
                     return;
                  end if;

                  exit when stk.is_empty = true;
                  rec := stk.pop;
                  p   := rec.pnt;
                  d := rec.num;

                  if d = 0 then
                     rec.pnt := p;
                     rec.num := 1;
                     stk.push (rec);

                     if p.rtag = false then
                        p := null;
                     else
                        p := p.rlink;
                     end if;
                  end if;
                  exit when d = 0;
               end loop;
            end if;
         end if;
      end loop;
   end postorder_iter;

   type stk_rec is record
      pnt : BSTptr;
      num : natural range 0 .. 1;
   end record;
   package post_stk is new stack (20, stk_rec);
   i : natural := 0;
   post_done : boolean := false;
   procedure postorder_recurs (point : in BSTptr) is
      p : BSTptr;
      rec : stk_rec;
      d   : natural range 0 .. 1;

      procedure reset is
         dispose : stk_rec;
      begin
         i := 0;

         if post_stk.is_empty = false then
            while post_stk.is_empty = false loop
               dispose := post_stk.pop;
            end loop;
         end if;
      end reset;

   begin
      p := point;
      loop
         if p /= null then
            rec.pnt := p;
            rec.num := 0;
            post_stk.push(rec);

            if p.ltag = false then
               postorder_recurs (null);
               if post_done = true then
                  reset;
                  return;
               end if;
            else
               postorder_recurs (p.llink);
               if post_done = true then
                  reset;
                  return;
               end if;
            end if;
         else
            exit when post_stk.is_empty = true;
            rec := post_stk.pop;
            p   := rec.pnt;
            d   := rec.num;

            if d = 0 then
               rec.pnt := p;
               rec.num := 1;
               post_stk.push(rec);

               if p.rtag = false then
                  postorder_recurs (null);
                  if post_done = true then
                     return;
                  end if;
               else
                  postorder_recurs (p.rlink);
                  if post_done = true then
                     return;
                  end if;
               end if;
            else
               loop
                  print_info (p);
                  i := i + 1;

                  if i = knt - 1 then
                     post_done := true;
                     reset;
                     return;
                  end if;

                  exit when post_stk.is_empty = true;
                  rec := post_stk.pop;
                  p   := rec.pnt;
                  d := rec.num;

                  if d = 0 then
                     rec.pnt := p;
                     rec.num := 1;
                     post_stk.push (rec);

                     if p.rtag = false then
                        postorder_recurs (null);
                        if post_done = true then
                           return;
                        end if;
                     else
                        postorder_recurs (p.rlink);
                        if post_done = true then
                           return;
                        end if;
                     end if;
                  end if;
                  exit when d = 0;
               end loop;
            end if;
         end if;
      end loop;
   end postorder_recurs;

   j : integer := 1;
   procedure reverse_in (point : BSTptr) is
      q : BSTptr;
   begin
      q := point;

      -- Right
      if q.rtag = true then
         reverse_in (q.rlink);
         if j > knt - 1 then
            return;
         end if;
      end if;

      -- Visit
      print_info (q);
      j := j + 1;
      if j > knt - 2 then
         return;
      end if;

      if q.ltag = true then
         reverse_in (q.llink);
         if j > knt - 2 then
            return;
         end if;
      end if;
   end reverse_in;

   function inorder_succ (point : in BSTptr) return BSTptr is
      q : BSTptr;
   begin
      q := point.rlink;

      if q = head then
         while q.ltag = true loop
            q := q.llink;
         end loop;
      end if;

      -- if a thread
      if point.rtag = false then
         return q;
      else
         while q.ltag = true loop
            q := q.llink;
         end loop;

         return q;
      end if;
   end inorder_succ;

   function inorder_pred (point : in BSTptr) return BSTptr is
      q : BSTptr;
   begin
      q := point.llink;

      if q = head then
         while q.rtag = true loop
            q := q.rlink;
         end loop;
      end if;

      -- if a thread
      if point.ltag = false then
         return q;
      else
         while q.rtag = true loop
            q := q.rlink;
         end loop;

         return q;
      end if;
   end inorder_pred;

   function cust_name (point : in BSTptr) return string10 is
   begin
      return point.info.name;
   end cust_name;

   function cust_phone (point : in BSTptr) return string10 is
   begin
      return point.info.phone;
   end cust_phone;

   function root return BSTptr is
   begin
      return head.llink;
   end root;

   procedure print_info (point : BSTptr) is
   begin
      new_line;
      put("Name: "); put(point.info.name);
      put("       Phone: "); put(point.info.phone);
      new_line;
   end print_info;

   procedure free_all is
      q, p : BSTptr;
   begin
      q := root;
      while q.ltag = true loop
         q := q.llink;
      end loop;

      p := inorder_succ (q);

      new_line;
      put_line ("Deallocating all nodes...");
      new_line;

      for i in 1 .. knt - 1 loop
         new_line;
         put ("Deallocating "); put (q.info.name);
         new_line;

         free (q);
         q := p;
         p := inorder_succ (p);
      end loop;

      -- Free head node
      new_line;
      put ("Deallocating head node...");
      new_line;
      free (head);

      new_line;
      put_line ("All nodes deallocated");
      new_line;
   end free_all;
   begin
      init;
   end BST;
