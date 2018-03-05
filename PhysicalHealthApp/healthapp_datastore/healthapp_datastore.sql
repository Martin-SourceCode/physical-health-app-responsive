PGDMP         #                v            healthapp_datastore    10.1    10.1 H    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    24596    healthapp_datastore    DATABASE     �   CREATE DATABASE healthapp_datastore WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United Kingdom.1252' LC_CTYPE = 'English_United Kingdom.1252';
 #   DROP DATABASE healthapp_datastore;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    32793    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                  false    5            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                       false    2                        3079    24605 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false    5            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    3            �            1255    32830 2   validateuser(character varying, character varying)    FUNCTION     B  CREATE FUNCTION validateuser(email character varying, upass character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
    DECLARE
      ref refcursor;
    BEGIN
      OPEN ref FOR SELECT * from app_user where emailaddress = email and userpassword = crypt(upass, userpassword);
      RETURN ref;
    END;
    $$;
 U   DROP FUNCTION public.validateuser(email character varying, upass character varying);
       public       postgres    false    1    5            �            1259    24813    app_organisation    TABLE     �  CREATE TABLE app_organisation (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _createdby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    organisationid integer NOT NULL,
    organisationname character varying(255),
    organisationimageurl character varying(500)
);
 $   DROP TABLE public.app_organisation;
       public         postgres    false    5            �            1259    32919    app_user    TABLE       CREATE TABLE app_user (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    userid integer NOT NULL,
    usertype character varying(255),
    userpassword character varying(255),
    profileimageurl character varying(500),
    gmccode character varying(255),
    matchedorganisationid integer,
    matchedclinicianid integer,
    nhsnumber character varying(255),
    emailaddress character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    dateofbirth timestamp without time zone,
    gender character varying(255),
    displayname character varying(255),
    organisationid integer,
    isactive boolean DEFAULT true,
    isclinician boolean DEFAULT false,
    issysadmin boolean DEFAULT false,
    isanonymous boolean DEFAULT false,
    isauthorised boolean DEFAULT false,
    authorisedtimestamp timestamp with time zone,
    authorisedby character varying(255),
    isrejected boolean DEFAULT false,
    rejectedtimestamp timestamp with time zone,
    rejectedby character varying(255),
    emailconfirmed boolean DEFAULT false,
    emailconfirmedtimestamp timestamp with time zone,
    title character varying(255),
    emailvalidationstring character varying(255) DEFAULT uuid_generate_v4(),
    acceptedtermsandconditions boolean,
    emailresetstring character varying(255) DEFAULT uuid_generate_v4()
);
    DROP TABLE public.app_user;
       public         postgres    false    3    5    3    5    5            �            1259    32941    activeclinician    VIEW     �  CREATE VIEW activeclinician AS
 SELECT a.userid,
    a.firstname,
    a.lastname,
    ((('Dr '::text || (a.firstname)::text) || ' '::text) || (a.lastname)::text) AS clinicianname,
    a.organisationid,
    o.organisationname,
    a.matchedorganisationid
   FROM (app_user a
     JOIN app_organisation o ON ((a.organisationid = o.organisationid)))
  WHERE ((a.isclinician = true) AND (a.isactive = true) AND (a.emailconfirmed = true) AND (a.isauthorised = true));
 "   DROP VIEW public.activeclinician;
       public       postgres    false    213    213    213    213    213    213    213    213    213    199    199    5            �            1259    24811 #   app_organisation_organisationid_seq    SEQUENCE     �   CREATE SEQUENCE app_organisation_organisationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.app_organisation_organisationid_seq;
       public       postgres    false    199    5            �           0    0 #   app_organisation_organisationid_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE app_organisation_organisationid_seq OWNED BY app_organisation.organisationid;
            public       postgres    false    198            �            1259    24872    app_organisationadmin    TABLE     �  CREATE TABLE app_organisationadmin (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    organisationadminid integer NOT NULL,
    organisationid integer,
    userid integer
);
 )   DROP TABLE public.app_organisationadmin;
       public         postgres    false    5            �            1259    24870 -   app_organisationadmin_organisationadminid_seq    SEQUENCE     �   CREATE SEQUENCE app_organisationadmin_organisationadminid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.app_organisationadmin_organisationadminid_seq;
       public       postgres    false    5    201            �           0    0 -   app_organisationadmin_organisationadminid_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE app_organisationadmin_organisationadminid_seq OWNED BY app_organisationadmin.organisationadminid;
            public       postgres    false    200            �            1259    24886    app_organisationemaildomain    TABLE     �  CREATE TABLE app_organisationemaildomain (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    organisationemaildomainid integer NOT NULL,
    organisationid integer,
    emaildomain character varying(255) NOT NULL
);
 /   DROP TABLE public.app_organisationemaildomain;
       public         postgres    false    5            �            1259    24884 9   app_organisationemaildomain_organisationemaildomainid_seq    SEQUENCE     �   CREATE SEQUENCE app_organisationemaildomain_organisationemaildomainid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public.app_organisationemaildomain_organisationemaildomainid_seq;
       public       postgres    false    203    5            �           0    0 9   app_organisationemaildomain_organisationemaildomainid_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE app_organisationemaildomain_organisationemaildomainid_seq OWNED BY app_organisationemaildomain.organisationemaildomainid;
            public       postgres    false    202            �            1259    24950    app_test    TABLE     p  CREATE TABLE app_test (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    testid integer NOT NULL,
    testtypeid integer,
    testnumericresult double precision,
    lowerreferencerange double precision,
    upperreferencerange double precision,
    unitstext character varying(255),
    testtextualresult character varying(255),
    userid integer,
    patientid integer,
    clinicianhasapproved boolean DEFAULT false,
    clinianhasapproveddate timestamp with time zone,
    clinicianmessage text,
    nexttestdate timestamp without time zone,
    testtypename character varying(555),
    patienthasviewed boolean,
    patientvieweddate timestamp with time zone
);
    DROP TABLE public.app_test;
       public         postgres    false    5            �            1259    24948    app_test_testid_seq    SEQUENCE     �   CREATE SEQUENCE app_test_testid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.app_test_testid_seq;
       public       postgres    false    205    5            �           0    0    app_test_testid_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE app_test_testid_seq OWNED BY app_test.testid;
            public       postgres    false    204            �            1259    24965    app_testtype    TABLE     �  CREATE TABLE app_testtype (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    testtypeid integer NOT NULL,
    testtypename character varying(255),
    lowerreferencerange double precision,
    upperreferencerange double precision,
    unitstext character varying(255)
);
     DROP TABLE public.app_testtype;
       public         postgres    false    5            �            1259    24963    app_testtype_testtypeid_seq    SEQUENCE     �   CREATE SEQUENCE app_testtype_testtypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.app_testtype_testtypeid_seq;
       public       postgres    false    5    207            �           0    0    app_testtype_testtypeid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE app_testtype_testtypeid_seq OWNED BY app_testtype.testtypeid;
            public       postgres    false    206            �            1259    32917    app_user_userid_seq    SEQUENCE     �   CREATE SEQUENCE app_user_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.app_user_userid_seq;
       public       postgres    false    213    5            �           0    0    app_user_userid_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE app_user_userid_seq OWNED BY app_user.userid;
            public       postgres    false    212            �            1259    32883    failedlogin    TABLE     �  CREATE TABLE failedlogin (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    failedloginid integer NOT NULL,
    emailaddress character varying(255),
    logintimestamp timestamp with time zone DEFAULT now(),
    ipaddress character varying(255)
);
    DROP TABLE public.failedlogin;
       public         postgres    false    5            �            1259    32881    failedlogin_failedloginid_seq    SEQUENCE     �   CREATE SEQUENCE failedlogin_failedloginid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.failedlogin_failedloginid_seq;
       public       postgres    false    211    5            �           0    0    failedlogin_failedloginid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE failedlogin_failedloginid_seq OWNED BY failedlogin.failedloginid;
            public       postgres    false    210            �            1259    32868    loginhistory    TABLE     �  CREATE TABLE loginhistory (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    loginhistoryid integer NOT NULL,
    userid integer,
    emailaddress character varying(255),
    logintimestamp timestamp with time zone DEFAULT now(),
    ipaddress character varying(255)
);
     DROP TABLE public.loginhistory;
       public         postgres    false    5            �            1259    32866    loginhistory_loginhistoryid_seq    SEQUENCE     �   CREATE SEQUENCE loginhistory_loginhistoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.loginhistory_loginhistoryid_seq;
       public       postgres    false    209    5            �           0    0    loginhistory_loginhistoryid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE loginhistory_loginhistoryid_seq OWNED BY loginhistory.loginhistoryid;
            public       postgres    false    208            �            1259    32992    systemsetup    TABLE     9  CREATE TABLE systemsetup (
    _createddate timestamp with time zone DEFAULT now() NOT NULL,
    _createdby character varying(255),
    _updateddate timestamp with time zone DEFAULT now() NOT NULL,
    _updatedby character varying(255),
    _recordstatus smallint DEFAULT 1 NOT NULL,
    systemsetupid integer NOT NULL,
    databaseconnectionmade boolean DEFAULT false,
    databasecreated boolean DEFAULT false,
    organisationcreated boolean DEFAULT false,
    cliniciancreated boolean DEFAULT false,
    superusercreated boolean DEFAULT false,
    setuplockedwithoutlogin boolean DEFAULT false,
    siteurlconfigured boolean DEFAULT false,
    emailconfigured boolean DEFAULT false,
    siteurl character varying(555),
    emailhost character varying(555),
    emailuser character varying(255),
    emailpassword character varying(255),
    emailport character varying(255),
    emailusetls boolean DEFAULT false,
    emailfromaddress character varying(555),
    emailfromname character varying(255),
    cliniciantermsandconditions text,
    patienttermsandconditions text
);
    DROP TABLE public.systemsetup;
       public         postgres    false    5            �
           2604    24819    app_organisation organisationid    DEFAULT     �   ALTER TABLE ONLY app_organisation ALTER COLUMN organisationid SET DEFAULT nextval('app_organisation_organisationid_seq'::regclass);
 N   ALTER TABLE public.app_organisation ALTER COLUMN organisationid DROP DEFAULT;
       public       postgres    false    198    199    199            �
           2604    24878 )   app_organisationadmin organisationadminid    DEFAULT     �   ALTER TABLE ONLY app_organisationadmin ALTER COLUMN organisationadminid SET DEFAULT nextval('app_organisationadmin_organisationadminid_seq'::regclass);
 X   ALTER TABLE public.app_organisationadmin ALTER COLUMN organisationadminid DROP DEFAULT;
       public       postgres    false    201    200    201            �
           2604    24892 5   app_organisationemaildomain organisationemaildomainid    DEFAULT     �   ALTER TABLE ONLY app_organisationemaildomain ALTER COLUMN organisationemaildomainid SET DEFAULT nextval('app_organisationemaildomain_organisationemaildomainid_seq'::regclass);
 d   ALTER TABLE public.app_organisationemaildomain ALTER COLUMN organisationemaildomainid DROP DEFAULT;
       public       postgres    false    202    203    203            �
           2604    24956    app_test testid    DEFAULT     d   ALTER TABLE ONLY app_test ALTER COLUMN testid SET DEFAULT nextval('app_test_testid_seq'::regclass);
 >   ALTER TABLE public.app_test ALTER COLUMN testid DROP DEFAULT;
       public       postgres    false    205    204    205            �
           2604    24971    app_testtype testtypeid    DEFAULT     t   ALTER TABLE ONLY app_testtype ALTER COLUMN testtypeid SET DEFAULT nextval('app_testtype_testtypeid_seq'::regclass);
 F   ALTER TABLE public.app_testtype ALTER COLUMN testtypeid DROP DEFAULT;
       public       postgres    false    207    206    207            �
           2604    32925    app_user userid    DEFAULT     d   ALTER TABLE ONLY app_user ALTER COLUMN userid SET DEFAULT nextval('app_user_userid_seq'::regclass);
 >   ALTER TABLE public.app_user ALTER COLUMN userid DROP DEFAULT;
       public       postgres    false    212    213    213            �
           2604    32889    failedlogin failedloginid    DEFAULT     x   ALTER TABLE ONLY failedlogin ALTER COLUMN failedloginid SET DEFAULT nextval('failedlogin_failedloginid_seq'::regclass);
 H   ALTER TABLE public.failedlogin ALTER COLUMN failedloginid DROP DEFAULT;
       public       postgres    false    211    210    211            �
           2604    32874    loginhistory loginhistoryid    DEFAULT     |   ALTER TABLE ONLY loginhistory ALTER COLUMN loginhistoryid SET DEFAULT nextval('loginhistory_loginhistoryid_seq'::regclass);
 J   ALTER TABLE public.loginhistory ALTER COLUMN loginhistoryid DROP DEFAULT;
       public       postgres    false    209    208    209            �          0    24813    app_organisation 
   TABLE DATA               �   COPY app_organisation (_createddate, _updateddate, _updatedby, _createdby, _recordstatus, organisationid, organisationname, organisationimageurl) FROM stdin;
    public       postgres    false    199   el       �          0    24872    app_organisationadmin 
   TABLE DATA               �   COPY app_organisationadmin (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, organisationadminid, organisationid, userid) FROM stdin;
    public       postgres    false    201   �l       �          0    24886    app_organisationemaildomain 
   TABLE DATA               �   COPY app_organisationemaildomain (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, organisationemaildomainid, organisationid, emaildomain) FROM stdin;
    public       postgres    false    203   �l       �          0    24950    app_test 
   TABLE DATA               a  COPY app_test (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, testid, testtypeid, testnumericresult, lowerreferencerange, upperreferencerange, unitstext, testtextualresult, userid, patientid, clinicianhasapproved, clinianhasapproveddate, clinicianmessage, nexttestdate, testtypename, patienthasviewed, patientvieweddate) FROM stdin;
    public       postgres    false    205   �l       �          0    24965    app_testtype 
   TABLE DATA               �   COPY app_testtype (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, testtypeid, testtypename, lowerreferencerange, upperreferencerange, unitstext) FROM stdin;
    public       postgres    false    207   �l       �          0    32919    app_user 
   TABLE DATA               $  COPY app_user (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, userid, usertype, userpassword, profileimageurl, gmccode, matchedorganisationid, matchedclinicianid, nhsnumber, emailaddress, firstname, lastname, dateofbirth, gender, displayname, organisationid, isactive, isclinician, issysadmin, isanonymous, isauthorised, authorisedtimestamp, authorisedby, isrejected, rejectedtimestamp, rejectedby, emailconfirmed, emailconfirmedtimestamp, title, emailvalidationstring, acceptedtermsandconditions, emailresetstring) FROM stdin;
    public       postgres    false    213   �l       �          0    32883    failedlogin 
   TABLE DATA               �   COPY failedlogin (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, failedloginid, emailaddress, logintimestamp, ipaddress) FROM stdin;
    public       postgres    false    211   m       �          0    32868    loginhistory 
   TABLE DATA               �   COPY loginhistory (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, loginhistoryid, userid, emailaddress, logintimestamp, ipaddress) FROM stdin;
    public       postgres    false    209   0m       �          0    32992    systemsetup 
   TABLE DATA               �  COPY systemsetup (_createddate, _createdby, _updateddate, _updatedby, _recordstatus, systemsetupid, databaseconnectionmade, databasecreated, organisationcreated, cliniciancreated, superusercreated, setuplockedwithoutlogin, siteurlconfigured, emailconfigured, siteurl, emailhost, emailuser, emailpassword, emailport, emailusetls, emailfromaddress, emailfromname, cliniciantermsandconditions, patienttermsandconditions) FROM stdin;
    public       postgres    false    215   Mm       �           0    0 #   app_organisation_organisationid_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('app_organisation_organisationid_seq', 1, true);
            public       postgres    false    198            �           0    0 -   app_organisationadmin_organisationadminid_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('app_organisationadmin_organisationadminid_seq', 1, false);
            public       postgres    false    200            �           0    0 9   app_organisationemaildomain_organisationemaildomainid_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('app_organisationemaildomain_organisationemaildomainid_seq', 1, false);
            public       postgres    false    202            �           0    0    app_test_testid_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('app_test_testid_seq', 1, false);
            public       postgres    false    204            �           0    0    app_testtype_testtypeid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('app_testtype_testtypeid_seq', 2, true);
            public       postgres    false    206            �           0    0    app_user_userid_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('app_user_userid_seq', 13, true);
            public       postgres    false    212            �           0    0    failedlogin_failedloginid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('failedlogin_failedloginid_seq', 22, true);
            public       postgres    false    210            �           0    0    loginhistory_loginhistoryid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('loginhistory_loginhistoryid_seq', 55, true);
            public       postgres    false    208                       2606    24824 &   app_organisation app_organisation_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY app_organisation
    ADD CONSTRAINT app_organisation_pkey PRIMARY KEY (organisationid);
 P   ALTER TABLE ONLY public.app_organisation DROP CONSTRAINT app_organisation_pkey;
       public         postgres    false    199                       2606    24883 0   app_organisationadmin app_organisationadmin_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY app_organisationadmin
    ADD CONSTRAINT app_organisationadmin_pkey PRIMARY KEY (organisationadminid);
 Z   ALTER TABLE ONLY public.app_organisationadmin DROP CONSTRAINT app_organisationadmin_pkey;
       public         postgres    false    201                       2606    24897 <   app_organisationemaildomain app_organisationemaildomain_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY app_organisationemaildomain
    ADD CONSTRAINT app_organisationemaildomain_pkey PRIMARY KEY (organisationemaildomainid);
 f   ALTER TABLE ONLY public.app_organisationemaildomain DROP CONSTRAINT app_organisationemaildomain_pkey;
       public         postgres    false    203                       2606    24962    app_test app_test_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY app_test
    ADD CONSTRAINT app_test_pkey PRIMARY KEY (testid);
 @   ALTER TABLE ONLY public.app_test DROP CONSTRAINT app_test_pkey;
       public         postgres    false    205                       2606    24976    app_testtype app_testtype_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY app_testtype
    ADD CONSTRAINT app_testtype_pkey PRIMARY KEY (testtypeid);
 H   ALTER TABLE ONLY public.app_testtype DROP CONSTRAINT app_testtype_pkey;
       public         postgres    false    207            !           2606    32937    app_user app_user_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (userid);
 @   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_pkey;
       public         postgres    false    213                       2606    32895    failedlogin failedlogin_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY failedlogin
    ADD CONSTRAINT failedlogin_pkey PRIMARY KEY (failedloginid);
 F   ALTER TABLE ONLY public.failedlogin DROP CONSTRAINT failedlogin_pkey;
       public         postgres    false    211                       2606    32880    loginhistory loginhistory_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY loginhistory
    ADD CONSTRAINT loginhistory_pkey PRIMARY KEY (loginhistoryid);
 H   ALTER TABLE ONLY public.loginhistory DROP CONSTRAINT loginhistory_pkey;
       public         postgres    false    209            #           2606    33011    systemsetup systemsetup_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY systemsetup
    ADD CONSTRAINT systemsetup_pkey PRIMARY KEY (systemsetupid);
 F   ALTER TABLE ONLY public.systemsetup DROP CONSTRAINT systemsetup_pkey;
       public         postgres    false    215            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x��PKo�@>;�b���"��bZ(�
jU	m�3ʾ��u��q�8p���a5��k����Y�8�
�ϫlQ��^f���E�%O�I�7@ε��6!�j>W��jc}��<ϋy�up£���:a0$���ɗw����w��ݾ>w��������^\���?>ߌ7�;*U�w���}9�����,>է�A�eR�콗G������u��Pk�h��ۤ�=q&�B��.�K�gI_M�+�j 磆�*;�� RcHAv�Q��}Dp��.HX�*%}
E�j2r$`�]����F��a��L��X�X�{�.Z�(�����A�)D��v�U�|l�c2#b=< ��	�Z�"�ҿ�S�ڐgވaʝN�8O˨{��U��3˱�	��H�Y�Nq�U��̈́L&ؐI�2���匳'1��~��:_     