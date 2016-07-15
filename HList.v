Set Implicit Arguments.
Unset Strict Implicit.

Require Import Coq.Lists.List.
Import ListNotations.

Inductive hlist A (f : A -> Type) : list A -> Type :=
| hnil : hlist f []
| hcons : forall x l, f x -> hlist f l -> hlist f (x :: l).

Notation " h[] " := (hnil _).
Infix "h::" := hcons (at level 60, right associativity).


Definition hmap A (f : A -> Type) B (g : B -> Type)
           (F : A -> B) (F' : forall a, f a -> g (F a))
           (l : list A) (h : hlist f l) : hlist g (map F l).
  induction h; constructor; auto.
Defined.

Definition hmap' A (f : A -> Type) (g : A -> Type)
           (F' : forall a, f a -> g a)
           (l : list A) (h : hlist f l) : hlist g l.
  replace l with (map id l).
  apply hmap with (f := f); assumption.
  clear f g F' h.
  induction l as [| x xs IHl]; [| simpl; rewrite IHl]; reflexivity.
Defined.