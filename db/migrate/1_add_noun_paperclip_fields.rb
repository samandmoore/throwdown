migration(1, :add_noun_paperclip_fields) do
	up do
		modify_table :nouns do
			add_column :image_file_name, "varchar(255)"
			add_column :image_content_type, "varchar(255)"
			add_column :image_file_size, "integer"
			add_column :image_updated_at, "datetime"
		end
	end

	down do
		modify_table :nouns do
			drop_columns :image_file_name, :image_content_type, :image_file_size, :image_updated_at
		end
	end
end