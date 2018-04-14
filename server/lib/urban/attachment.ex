defmodule Urban.Attachment do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname()
      |> String.downcase()

    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {
      :convert,
      "-thumbnail 100x100^ -gravity center -extent 100x100 -format png",
      :png
    }
  end

  def filename(version, {file, scope}) do
    file_name =
      file.file_name
      |> Path.basename(Path.extname(file.file_name))

    id_version = "#{scope.id}_#{version}_"

    if String.starts_with?(file_name, id_version) do
      file_name
    else
      "#{id_version}#{file_name}"
    end
    |> IO.inspect()
  end

  def storage_dir(_, {_file, %{__meta__: %{source: {_, table}}}}) do
    "api/uploads/#{table}"
  end

  def default_url(:thumb) do
    "/not-found.jpeg/100x100"
  end
end
