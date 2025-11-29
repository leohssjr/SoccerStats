

CREATE TABLE gold.dim_atl (
	srk_atl bigserial NOT NULL,
	atl_idn int8 NULL,
	atl_ape text NULL,
	atl_pid int8 NULL,
	atl_pos text NULL,
	CONSTRAINT dim_atl_pkey PRIMARY KEY (srk_atl)
);

CREATE TABLE gold.dim_clb (
	srk_clb bigserial NOT NULL,
	clb_idn int8 NULL,
	clb_nme text NULL,
	clb_abv text NULL,
	clb_slg text NULL,
	CONSTRAINT dim_clb_pkey PRIMARY KEY (srk_clb)
);

CREATE TABLE gold.dim_par (
	srk_par bigserial NOT NULL,
	par_idn int8 NULL,
	par_tmp int4 NULL,
	par_rod int8 NULL,
	par_cid int8 NULL,
	par_cnm text NULL,
	par_vid int8 NULL,
	par_vnm text NULL,
	par_plm float8 NULL,
	par_plv float8 NULL,
	CONSTRAINT dim_par_pkey PRIMARY KEY (srk_par)
);

CREATE TABLE gold.fat_fcp (
	srk_fcp bigserial NOT NULL,
	srk_atl int8 NOT NULL,
	srk_clb int8 NULL,
	srk_par int8 NOT NULL,
	fcp_tmp int4 NULL,
	fcp_caf text NULL,
	fcp_med float8 NULL,
	fcp_prc float8 NULL,
	fcp_pts float8 NULL,
	fcp_var float8 NULL,
	fcp_pfs int8 NULL,
	fcp_ppe int8 NULL,
	fcp_pas int8 NULL,
	fcp_pft int8 NULL,
	fcp_pfd int8 NULL,
	fcp_pff int8 NULL,
	fcp_pgl int8 NULL,
	fcp_pim int8 NULL,
	fcp_ppp int8 NULL,
	fcp_prb int8 NULL,
	fcp_pfc int8 NULL,
	fcp_pgc int8 NULL,
	fcp_pca int8 NULL,
	fcp_pcv int8 NULL,
	fcp_png int8 NULL,
	fcp_pdd int8 NULL,
	fcp_pdp int8 NULL,
	fcp_pgs int8 NULL,
	CONSTRAINT fat_fcp_pkey PRIMARY KEY (srk_fcp)
);