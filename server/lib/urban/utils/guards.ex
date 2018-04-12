defmodule Urban.Utils.Guards do
  defguard is_map_list_list_atom(m, l1, l2, a)
           when is_map(m) and is_list(l1) and is_list(l2) and is_atom(a)

  defguard is_list_atom_list(l, a, l1) when is_list(l) and is_atom(a) and is_list(l1)
end
