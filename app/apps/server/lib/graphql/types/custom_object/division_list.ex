defmodule Graphql.Types.CustomObject.DivisionList do
  use Absinthe.Schema.Notation

  object :division_list do
    field(:entries, non_null(list_of(non_null(:division))))
    import_fields(:pagination)
  end
end
