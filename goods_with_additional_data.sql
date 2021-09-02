SET @additional_data_query = NULL;
SELECT
 GROUP_CONCAT(DISTINCT
    CONCAT(
      'ifnull(MAX(case when additional_fields.name = ''',
      additional_fields.name,
      ''' then additional_field_values.name end),"") AS `',
      additional_fields.name, '`'
    )
  ) 
  INTO @additional_data_query
  FROM
  additional_goods_field_values 
  	LEFT JOIN  additional_fields
     ON additional_goods_field_values.additional_field_id = additional_fields.id
    LEFT JOIN additional_field_values 
    	ON additional_field_values.id = additional_goods_field_values.additional_field_value_id 
        	AND additional_field_values.additional_field_id = additional_goods_field_values.additional_field_id;
  
SET @query = CONCAT('
				SELECT goods.name as Product, ', @additional_data_query, '
				FROM goods   
					LEFT JOIN additional_goods_field_values 
						ON additional_goods_field_values.good_id = goods.id
					LEFT JOIN additional_fields
						ON additional_goods_field_values.additional_field_id = additional_fields.id
					LEFT JOIN additional_field_values 
						ON additional_field_values.id = additional_goods_field_values.additional_field_value_id 
							AND additional_field_values.additional_field_id = additional_goods_field_values.additional_field_id
					GROUP BY goods.id');
    
    
PREPARE items_with_additional_data FROM @query;
EXECUTE items_with_additional_data;
DEALLOCATE PREPARE items_with_additional_data;