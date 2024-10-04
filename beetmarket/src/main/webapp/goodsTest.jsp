select
		g.cateHighNo,
		g.cateMidNo,
		g.cateLowNo,
		c.categoryName,

		g.goodsNo,
		g.goodsName,
		g.goodsMainImage,
		g.goodsConImage,
		g.goodsContent,
		g.goodsHit,
		g.goodsOriPrice,
		g.goodsDiscRate,
		g.goodsDiscount,
		g.goodsPrice,
		g.goodsSavings,
		g.goodsSaveRate,

		o.goodsOptPrice,
		o.goodsOptName,

		i.goodsInfoName,
		i.goodsInfoCon,

		s.goodsStatusName
		
		h.id
		h.store_name

		from goods g, goodsOption o, category c, goodsInfo i, goodsStatus s, seller_hub h
		where (g.goodsNo = #{goodsNo})
		and
		(g.goodsNo = o.goodsNo
		and
		g.cateHighNo = c.cateHighNo and g.cateMidNo = c.cateMidNo and
		g.cateLowNo = c.cateLowNo
		and g.goodsNo = i.goodsNo
		and g.goodsStatusNo
		= s.goodsStatusNo and g.sell_no = h.sell_no)