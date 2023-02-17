defmodule Actions.Graph.Mixin.DivisionFuncs.Create do
  def set_hash(attrs) do
    now = DateTime.utc_now()
    datetime = Calendar.strftime(now, "_%y-%m-%d_%H:%M:%S")

    attrs
    |> Map.put(:changed_at, now)
    |> Map.put(:division_hash, sha256(attrs.name <> datetime))
  end

  def sha256(data) do
    :crypto.hash(:sha256, data) |> Base.encode16(case: :lower)
  end
end
