INSERT INTO dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_9 (par_rnum2, par_cobj_gid2, version_id, hash_diff, department, uniq_num, src_cd, report_date, row_num, zp_par_rnum, par_rnum, cobj_gid, zp_cobj_gid, par_cobj_gid, insc_gid, ccrt_gid, dept_nm, clnt_bnsz_nm, clnt_nm, clnt_inn_kio_no, clnt_reg_no, deal_no, deal_begin_dt, deal_crnc_cd, deal_dltp_nm, deal_planend_dt, deal_acnt_no, deal_rur_amt, dept_empl_nm, dept_cd, cobj_balance_rur_amt, cobj_deal_oth_no, acnt_no, ccrt_no, ccrt_sign_dt, ccrt_plan_end_dt, ccrt_add_no, ccrt_type_nm, cobj_cols_nm, cobj_main_coll_nm, cobj_acnt_no, ccrt_clnt_nm, ccrt_clnt_inn_no, ccrt_clnt_reg_no, ccrt_rur_amt, cobj_acnt_oth_no, cobj_clqt_nm, reason_nm, liquid_flg, cobj_assessed_dt, cobj_empl_assessed_nm, cobj_assessed_rur_amt, cobj_market_rur_amt, ins_crt_no, ins_cpty_insurer_nm, ins_cpty_insurer_inn_no, ins_end_dt, ins_rur_amt, ins_paid_end_dt, ins_risk_loss_flg, cobj_desc, cobj_address_desc, cobj_dpos_nm, cobj_dpos_good_flg, state_reg_dt, state_reg_no, cobj_clnt_sec_issuer_nm, cobj_sec_isin_no, cobj_sect_nm, cobj_sec_listed_nm, cobj_sec_maturity_dt, cobj_clnt_sec_issuer_type_nm, cobj_clnt_sec_issuer_inn_no, cobj_clnt_sec_issuer_reg_no, cobj_sec_qty_nm, cobj_reval_dept_nm, cobj_reval_type_nm, file_cobj_reval_freq_val, cobj_reval_freq_val, cobj_reval_last_dt, cobj_reval_plan_dt, cobj_reval_comment_desc, init_dept_name, init_empl_name, comment_desc, fkr_nm, is_monitoring_report_flg, clnt_inn_no, emit_inn_no, ccrt_subsec_coll_vtb_flg, par_acnt_no, par_deal_no, rn) WITH RECURSIVE w034 AS
  (SELECT w0_1.*,
          row_number() over(PARTITION BY w0_1.row_num, w0_1.version_id) AS lvl
   FROM
     (SELECT w0.*,
             CASE
                 WHEN w0.cobj_deal_oth_no IS NOT NULL THEN unnest(string_to_array(btrim(w0.cobj_deal_oth_no)::text, ';'))
                 ELSE w0.cobj_deal_oth_no
             END AS cobj_deal_oth_no_new
      FROM dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_6 w0) w0_1),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           w035 AS
  (SELECT *
   FROM dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_6 w0
   WHERE UPPER (coalesce(w0.cobj_deal_oth_no, '0')) <> 'НЕТ'
     AND COALESCE (w0.ccrt_no,
                   w0.ccrt_type_nm,
                   w0.cobj_cols_nm,
                   w0.ccrt_clnt_nm,
                   w0.cobj_desc) IS NOT NULL ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           w036 AS
  (SELECT q2.*,
          CASE
              WHEN COALESCE (q2.ccrt_no,
                             q2.ccrt_type_nm,
                             q2.cobj_cols_nm,
                             q2.ccrt_clnt_nm,
                             q2.cobj_desc) IS NULL THEN 'Y'
              ELSE 'N'
          END flg,
          COALESCE (w1_1.deal_no,
                    w1_2.deal_no,
                    w1_3.deal_no) AS par_deal_no,
                   COALESCE (w1_1.cobj_acnt_no,
                             w1_2.cobj_acnt_no,
                             w1_3.cobj_acnt_no) AS par_acnt_no,
                            COALESCE (w1_1.row_num,
                                      w1_2.row_num,
                                      w1_3.row_num) AS par_rnum,
                                     COALESCE (w1_1.cobj_gid,
                                               w1_2.cobj_gid,
                                               w1_3.cobj_gid) AS par_cobj_gid,
                                              CASE
                                                  WHEN DECODE (1,
                                                               w1_1.rn_d1,
                                                               w1_1.ccrt_sign_dt,
                                                               w1_2.rn_d2,
                                                               w1_2.ccrt_sign_dt,
                                                               w1_3.rn_d3,
                                                               w1_3.ccrt_sign_dt)::date = q2.ccrt_sign_dt
                                                       AND DECODE (1,
                                                                   w1_1.rn_d1,
                                                                   w1_1.ccrt_no,
                                                                   w1_2.rn_d2,
                                                                   w1_2.ccrt_no,
                                                                   w1_3.rn_d3,
                                                                   w1_3.ccrt_no) = q2.ccrt_no THEN 'N'
                                                  WHEN COALESCE (w1_1.rn_d1,
                                                                 w1_2.rn_d2,
                                                                 w1_3.rn_d3) = 1 THEN 'Y'
                                                  ELSE 'N'
                                              END AS ccrt_subsec_coll_vtb_flg,
                                              w1_1.rn_d1,
                                              w1_2.rn_d2,
                                              w1_3.rn_d3
   FROM w034 q2
   LEFT JOIN dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_7 w1_1 ON q2.cobj_deal_oth_no_new = w1_1.deal_no
   AND w1_1.rn_d1 = 1
   AND coalesce(q2.cobj_balance_rur_amt, 0) = 0
   LEFT JOIN dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_7 w1_2 ON q2.cobj_deal_oth_no_new = w1_2.deal_no
   AND q2.cobj_cols_nm = w1_2.cobj_cols_nm
   AND q2.cobj_desc = w1_2.cobj_desc
   AND w1_2.rn_d1 != 1
   AND w1_2.rn_d2 = 1
   AND coalesce(q2.cobj_balance_rur_amt, 0) = 0
   LEFT JOIN dm_pik_duio_rwa_work.mrod_rsa_stg_zp_spp_7 w1_3 ON q2.cobj_deal_oth_no_new = w1_3.deal_no
   AND q2.cobj_cols_nm = w1_3.cobj_cols_nm
   AND q2.cobj_desc = w1_3.cobj_desc
   AND DECODE (q2.cobj_sec_isin_no,
               w1_3.cobj_sec_isin_no,
               1,
               0) = 1
   AND DECODE (q2.cobj_clnt_sec_issuer_inn_no,
               w1_3.cobj_clnt_sec_issuer_inn_no,
               1,
               0) = 1
   AND DECODE (q2.cobj_clnt_sec_issuer_reg_no,
               w1_3.cobj_clnt_sec_issuer_reg_no,
               1,
               0) = 1
   AND coalesce(q2.cobj_acnt_no, q2.cobj_acnt_oth_no) = w1_3.cobj_acnt_no
   AND w1_3.rn_d1 != 1
   AND w1_3.rn_d2 != 1
   AND w1_3.rn_d3 = 1
   AND COALESCE (q2.cobj_balance_rur_amt,
                 0) = 0),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           w3_1 AS
  (SELECT q3.version_id,
          q3.hash_diff,
          q3.department,
          q3.uniq_num,
          q3.src_cd,
          q3.report_date,
          q3.row_num,
          w0.row_num AS zp_par_rnum,
          q3.par_rnum,
          q3.cobj_gid,
          w0.cobj_gid AS zp_cobj_gid,
          q3.par_cobj_gid,
          coalesce(w0.row_num::text, w0.insc_gid, q3.insc_gid) AS insc_gid,
          CASE
              WHEN HASHTEXT(q3.report_date::text || coalesce(q3.row_num, '0')::text || ' ' || coalesce(q3.cobj_deal_oth_no, '-')::text || ' ' || coalesce(q3.version_id, '0')::text)::text like '-%' THEN HASHTEXT(q3.report_date::text || coalesce(q3.row_num, '0')::text || ' ' || coalesce(q3.cobj_deal_oth_no, '-')::text || ' ' || coalesce(q3.version_id, '0')::text)::text
              ELSE '-'::text || HASHTEXT(q3.report_date::text || coalesce(q3.row_num, '0')::text || ' ' || coalesce(q3.cobj_deal_oth_no, '-')::text || ' ' || coalesce(q3.version_id, '0')::text)::text
          END AS ccrt_gid,
          q3.dept_nm,
          q3.clnt_bnsz_nm,
          q3.clnt_nm,
          q3.clnt_inn_kio_no,
          q3.clnt_reg_no,
          q3.deal_no,
          q3.deal_begin_dt,
          q3.deal_crnc_cd,
          q3.deal_dltp_nm,
          q3.deal_planend_dt,
          q3.deal_acnt_no,
          q3.deal_rur_amt,
          q3.dept_empl_nm,
          q3.dept_cd,
          q3.cobj_balance_rur_amt,
          q3.cobj_deal_oth_no,
          coalesce(w0.row_num::text, w0.cobj_acnt_oth_no, coalesce(q3.cobj_acnt_oth_no, q3.cobj_acnt_no)) AS acnt_no,
          coalesce(w0.row_num::text, w0.ccrt_no, q3.ccrt_no) AS ccrt_no,
          coalesce(w0.row_num::text, w0.ccrt_sign_dt::text, q3.ccrt_sign_dt::text) AS ccrt_sign_dt,
          coalesce(w0.row_num::text, w0.ccrt_plan_end_dt::text, q3.ccrt_plan_end_dt::text) AS ccrt_plan_end_dt,
          coalesce(w0.row_num::text, w0.ccrt_add_no, q3.ccrt_add_no) AS ccrt_add_no,
          coalesce(w0.row_num::text, w0.ccrt_type_nm, q3.ccrt_type_nm) AS ccrt_type_nm,
          coalesce(w0.row_num::text, w0.cobj_cols_nm, q3.cobj_cols_nm) AS cobj_cols_nm,
          coalesce(w0.row_num::text, w0.cobj_main_coll_nm, q3.cobj_main_coll_nm) AS cobj_main_coll_nm,
          coalesce(w0.row_num::text, w0.cobj_acnt_no, q3.cobj_acnt_no) AS cobj_acnt_no,
          coalesce(w0.row_num::text, w0.ccrt_clnt_nm, q3.ccrt_clnt_nm) AS ccrt_clnt_nm,
          coalesce(w0.row_num::text, w0.ccrt_clnt_inn_no, q3.ccrt_clnt_inn_no) AS ccrt_clnt_inn_no,
          coalesce(w0.row_num::text, w0.ccrt_clnt_reg_no, q3.ccrt_clnt_reg_no) AS ccrt_clnt_reg_no,
          coalesce(w0.row_num, w0.ccrt_rur_amt, q3.ccrt_rur_amt) AS ccrt_rur_amt,
          coalesce(w0.row_num::text, w0.cobj_acnt_oth_no, q3.cobj_acnt_oth_no) AS cobj_acnt_oth_no,
          coalesce(w0.row_num::text, w0.cobj_clqt_nm, q3.cobj_clqt_nm) AS cobj_clqt_nm,
          coalesce(w0.row_num::text, w0.reason_nm, q3.reason_nm) AS reason_nm,
          coalesce(w0.row_num::text, w0.liquid_flg, q3.liquid_flg) AS liquid_flg,
          coalesce(w0.row_num::text, w0.cobj_assessed_dt::text, q3.cobj_assessed_dt::text) AS cobj_assessed_dt,
          coalesce(w0.row_num::text, w0.cobj_empl_assessed_nm, q3.cobj_empl_assessed_nm) AS cobj_empl_assessed_nm,
          coalesce(w0.row_num, w0.cobj_assessed_rur_amt, q3.cobj_assessed_rur_amt) AS cobj_assessed_rur_amt,
          coalesce(w0.row_num, w0.cobj_market_rur_amt, q3.cobj_market_rur_amt) AS cobj_market_rur_amt,
          coalesce(w0.row_num::text, w0.ins_crt_no, q3.ins_crt_no) AS ins_crt_no,
          coalesce(w0.row_num::text, w0.ins_cpty_insurer_nm, q3.ins_cpty_insurer_nm) AS ins_cpty_insurer_nm,
          coalesce(w0.row_num::text, w0.ins_cpty_insurer_inn_no, q3.ins_cpty_insurer_inn_no) AS ins_cpty_insurer_inn_no,
          coalesce(w0.row_num::text, w0.ins_end_dt, q3.ins_end_dt) AS ins_end_dt,
          coalesce(w0.row_num, w0.ins_rur_amt, q3.ins_rur_amt) AS ins_rur_amt,
          coalesce(w0.row_num::text, w0.ins_paid_end_dt::text, q3.ins_paid_end_dt::text) AS ins_paid_end_dt,
          coalesce(w0.row_num::text, w0.ins_risk_loss_flg, q3.ins_risk_loss_flg) AS ins_risk_loss_flg,
          coalesce(w0.row_num::text, w0.cobj_desc, q3.cobj_desc) AS cobj_desc,
          coalesce(w0.row_num::text, w0.cobj_address_desc, q3.cobj_address_desc) AS cobj_address_desc,
          coalesce(w0.row_num::text, w0.cobj_dpos_nm, q3.cobj_dpos_nm) AS cobj_dpos_nm,
          coalesce(w0.row_num::text, w0.cobj_dpos_good_flg, q3.cobj_dpos_good_flg) AS cobj_dpos_good_flg,
          coalesce(w0.row_num::text, w0.state_reg_dt::text, q3.state_reg_dt::text) AS state_reg_dt,
          coalesce(w0.row_num::text, w0.state_reg_no, q3.state_reg_no) AS state_reg_no,
          coalesce(w0.row_num::text, w0.cobj_clnt_sec_issuer_nm, q3.cobj_clnt_sec_issuer_nm) AS cobj_clnt_sec_issuer_nm,
          coalesce(w0.row_num::text, w0.cobj_sec_isin_no, q3.cobj_sec_isin_no) AS cobj_sec_isin_no,
          coalesce(w0.row_num::text, w0.cobj_sect_nm, q3.cobj_sect_nm) AS cobj_sect_nm,
          coalesce(w0.row_num::text, w0.cobj_sec_listed_nm, q3.cobj_sec_listed_nm) AS cobj_sec_listed_nm,
          coalesce(w0.row_num::text, w0.cobj_sec_maturity_dt::text, q3.cobj_sec_maturity_dt::text) AS cobj_sec_maturity_dt,
          coalesce(w0.row_num::text, w0.cobj_clnt_sec_issuer_type_nm, q3.cobj_clnt_sec_issuer_type_nm) AS cobj_clnt_sec_issuer_type_nm,
          coalesce(w0.row_num::text, w0.cobj_clnt_sec_issuer_inn_no, q3.cobj_clnt_sec_issuer_inn_no) AS cobj_clnt_sec_issuer_inn_no,
          coalesce(w0.row_num::text, w0.cobj_clnt_sec_issuer_reg_no, q3.cobj_clnt_sec_issuer_reg_no) AS cobj_clnt_sec_issuer_reg_no,
          coalesce(w0.row_num::text, w0.cobj_sec_qty_nm, q3.cobj_sec_qty_nm) AS cobj_sec_qty_nm,
          coalesce(w0.row_num::text, w0.cobj_reval_dept_nm, q3.cobj_reval_dept_nm) AS cobj_reval_dept_nm,
          coalesce(w0.row_num::text, w0.cobj_reval_type_nm, q3.cobj_reval_type_nm) AS cobj_reval_type_nm,
          coalesce(w0.row_num, w0.cobj_reval_freq_val, q3.cobj_reval_freq_val) AS file_cobj_reval_freq_val,
          CASE
              WHEN w0.row_num IS NOT NULL THEN CASE
                                                   WHEN w0.cobj_reval_freq_val < 92 THEN w0.cobj_reval_freq_val
                                                   WHEN ('2023-12-31'::date - w0.cobj_assessed_dt)::numeric < 92 THEN ('2023-12-31'::date - w0.cobj_assessed_dt)::numeric
                                                   ELSE w0.cobj_reval_freq_val
                                               END
              ELSE CASE
                       WHEN q3.cobj_reval_freq_val < 92 THEN q3.cobj_reval_freq_val
                       WHEN ('2023-12-31'::date - q3.cobj_assessed_dt)::numeric < 92 THEN ('2023-12-31'::date - q3.cobj_assessed_dt)::numeric
                       ELSE q3.cobj_reval_freq_val
                   END
          END AS cobj_reval_freq_val,
          coalesce(w0.row_num::text, w0.cobj_reval_last_dt::text, q3.cobj_reval_last_dt::text) AS cobj_reval_last_dt,
          coalesce(w0.row_num::text, w0.cobj_reval_plan_dt::text, q3.cobj_reval_plan_dt::text) AS cobj_reval_plan_dt,
          coalesce(w0.row_num::text, w0.cobj_reval_comment_desc, q3.cobj_reval_comment_desc) AS cobj_reval_comment_desc,
          coalesce(w0.row_num::text, w0.init_dept_name, q3.init_dept_name) AS init_dept_name,
          coalesce(w0.row_num::text, w0.init_empl_name, q3.init_empl_name) AS init_empl_name,
          coalesce(w0.row_num::text, w0.comment_desc, q3.comment_desc) AS comment_desc,
          coalesce(w0.row_num::text, w0.fkr_nm, q3.fkr_nm) AS fkr_nm,
          coalesce(w0.row_num::text, w0.is_monitoring_report_flg, q3.is_monitoring_report_flg) AS is_monitoring_report_flg,
          CASE
              WHEN w0.row_num IS NOT NULL THEN coalesce(w0.ccrt_clnt_inn_no, w0.ccrt_clnt_reg_no)
              ELSE coalesce(q3.ccrt_clnt_inn_no, q3.ccrt_clnt_reg_no)
          END AS clnt_inn_no,
          CASE
              WHEN w0.row_num IS NOT NULL THEN coalesce(decode(w0.cobj_cols_nm, 'Векселя ВТБ', '7702070139', NULL), w0.cobj_clnt_sec_issuer_inn_no, w0.cobj_clnt_sec_issuer_reg_no)
              ELSE COALESCE (decode(q3.cobj_cols_nm, 'Векселя ВТБ', '7702070139', NULL),
                             q3.cobj_clnt_sec_issuer_inn_no,
                             q3.cobj_clnt_sec_issuer_reg_no)
          END AS emit_inn_no,
          q3.ccrt_subsec_coll_vtb_flg,
          q3.par_acnt_no,
          q3.par_deal_no,
          rank () OVER (PARTITION BY q3.row_num
                        ORDER BY CASE
                                     WHEN w0.row_num IS NOT NULL THEN 1
                                     ELSE 2
                                 END,
                                 CASE
                                     WHEN w0.row_num IS NOT NULL THEN q3.lvl
                                     ELSE NULL
                                 END,
                                 CASE
                                     WHEN COALESCE (q3.rn_d1,
                                                    q3.rn_d2,
                                                    q3.rn_d3) IS NULL THEN 2
                                     ELSE 1
                                 END,
                                 q3.lvl) AS rn
   FROM w036 q3
   LEFT JOIN w035 w0 ON TRIM (q3.cobj_deal_oth_no_new) = TRIM (w0.deal_no)
   AND q3.flg = 'Y'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           w3_rec AS
  (SELECT w3_1.*,
          w3_1.row_num AS root_rnum,
          w3_1.cobj_gid AS root_cobj_gid
   FROM w3_1 w3_1
   WHERE COALESCE (w3_1.zp_par_rnum,
                   w3_1.par_rnum) IS NULL
   UNION ALL SELECT w3_1.*,
                    c.root_rnum,
                    c.root_cobj_gid
   FROM w3_1 w3_1
   INNER JOIN w3_rec c ON COALESCE (c.zp_par_rnum,
                                    c.par_rnum) = w3_1.row_num)
SELECT CASE
           WHEN root_rnum = row_num THEN NULL
           ELSE root_rnum
       END AS par_rnum2,
       root_cobj_gid AS par_cobj_gid2,
       version_id,
       hash_diff,
       department,
       uniq_num,
       src_cd,
       report_date,
       row_num,
       zp_par_rnum,
       par_rnum,
       cobj_gid,
       zp_cobj_gid,
       par_cobj_gid,
       insc_gid,
       ccrt_gid,
       dept_nm,
       clnt_bnsz_nm,
       clnt_nm,
       clnt_inn_kio_no,
       clnt_reg_no,
       deal_no,
       deal_begin_dt,
       deal_crnc_cd,
       deal_dltp_nm,
       deal_planend_dt,
       deal_acnt_no,
       deal_rur_amt,
       dept_empl_nm,
       dept_cd,
       cobj_balance_rur_amt,
       cobj_deal_oth_no,
       acnt_no,
       ccrt_no,
       ccrt_sign_dt,
       ccrt_plan_end_dt,
       ccrt_add_no,
       ccrt_type_nm,
       cobj_cols_nm,
       cobj_main_coll_nm,
       cobj_acnt_no,
       ccrt_clnt_nm,
       ccrt_clnt_inn_no,
       ccrt_clnt_reg_no,
       ccrt_rur_amt,
       cobj_acnt_oth_no,
       cobj_clqt_nm,
       reason_nm,
       liquid_flg,
       cobj_assessed_dt,
       cobj_empl_assessed_nm,
       cobj_assessed_rur_amt,
       cobj_market_rur_amt,
       ins_crt_no,
       ins_cpty_insurer_nm,
       ins_cpty_insurer_inn_no,
       ins_end_dt,
       ins_rur_amt,
       ins_paid_end_dt,
       ins_risk_loss_flg,
       cobj_desc,
       cobj_address_desc,
       cobj_dpos_nm,
       cobj_dpos_good_flg,
       state_reg_dt,
       state_reg_no,
       cobj_clnt_sec_issuer_nm,
       cobj_sec_isin_no,
       cobj_sect_nm,
       cobj_sec_listed_nm,
       cobj_sec_maturity_dt,
       cobj_clnt_sec_issuer_type_nm,
       cobj_clnt_sec_issuer_inn_no,
       cobj_clnt_sec_issuer_reg_no,
       cobj_sec_qty_nm,
       cobj_reval_dept_nm,
       cobj_reval_type_nm,
       file_cobj_reval_freq_val,
       cobj_reval_freq_val,
       cobj_reval_last_dt,
       cobj_reval_plan_dt,
       cobj_reval_comment_desc,
       init_dept_name,
       init_empl_name,
       comment_desc,
       fkr_nm,
       is_monitoring_report_flg,
       clnt_inn_no,
       emit_inn_no,
       ccrt_subsec_coll_vtb_flg,
       par_acnt_no,
       par_deal_no,
       rn
FROM w3_rec q3_rec
WHERE rn = 1
