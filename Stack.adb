--Binary Search Tree Lab
--A Option
--Nathan Robinson

package body stack is
   max       : natural := stackMax;
   top       : natural range 0 .. max := 0;
   overflow  : boolean := false;
   underflow : boolean := false;
   stack_arr : array (1 .. max) of item;

   procedure setMax (new_max : in natural) is
   begin
      max := new_max;
   end setMax;

   procedure push (new_item : in item) is
   begin
      if (top < max) then
         underflow := false;
         top := top + 1;
         stack_arr (top) := new_item;
      else
         overflow := true;
         new_line; put_line("Oveflow occured: stack full");
      end if;
   end push;

   function pop return item is
      blank : item;
   begin
      if (top > 0) then
         overflow := false;
         top := top - 1;
         return stack_arr(top + 1);
      else
         underflow := true;
         new_line; put_line("Underflow occured: stack empty");
         return blank;
      end if;
   end pop;

   function peek return item is
      blank : item;
   begin
      if is_empty then
         return blank;
      else
         return stack_arr (top);
      end if;
   end peek;

   function is_empty return boolean is begin
      if (top = 0) then return true;
      else return false;
      end if;
   end is_empty;

   function is_full return boolean is begin
      if (top = max) then return true;
      else return false;
      end if;
   end is_full;

   function is_overflow return boolean is begin
      if (overflow) then return true;
      else return false;
      end if;
   end is_overflow;

   function is_underflow return boolean is begin
      if (underflow) then return true;
      else return false;
      end if;
   end is_underflow;
end stack;
