defimpl ExAdmin.Render, for: Tuple do
  def to_string({:map, :metadata}) do
    "Metadata"
  end
end
