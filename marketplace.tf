resource "oci_marketplace_accepted_agreement" "AlmaLinux_Accepted_Agreement" {
  agreement_id    = oci_marketplace_listing_package_agreement.AlmaLinux_Listing_Package_Agreement.agreement_id
  compartment_id  = local.compartment_id
  listing_id      = data.oci_marketplace_listing.AlmaLinux_Listing.id
  package_version = data.oci_marketplace_listing.AlmaLinux_Listing.default_package_version
  signature       = oci_marketplace_listing_package_agreement.AlmaLinux_Listing_Package_Agreement.signature
}

resource "oci_marketplace_listing_package_agreement" "AlmaLinux_Listing_Package_Agreement" {
  agreement_id    = data.oci_marketplace_listing_package_agreements.AlmaLinux_Listing_Package_Agreements.agreements.0.id
  listing_id      = data.oci_marketplace_listing.AlmaLinux_Listing.id
  package_version = data.oci_marketplace_listing.AlmaLinux_Listing.default_package_version
}

data "oci_marketplace_listing_package_agreements" "AlmaLinux_Listing_Package_Agreements" {
  listing_id      = data.oci_marketplace_listing.AlmaLinux_Listing.id
  package_version = data.oci_marketplace_listing.AlmaLinux_Listing.default_package_version
  compartment_id  = local.compartment_id
}

data "oci_marketplace_listing_package" "AlmaLinux_Listing_Package" {
  listing_id      = data.oci_marketplace_listing.AlmaLinux_Listing.id
  package_version = data.oci_marketplace_listing.AlmaLinux_Listing.default_package_version
  compartment_id  = local.compartment_id
}

data "oci_marketplace_listing_packages" "AlmaLinux_Listing_Packages" {
  listing_id     = data.oci_marketplace_listing.AlmaLinux_Listing.id
  compartment_id = local.compartment_id
}

data "oci_marketplace_listing" "AlmaLinux_Listing" {
  listing_id     = data.oci_marketplace_listings.AlmaLinux_Listings.listings.0.id
  compartment_id = local.compartment_id
}

data "oci_marketplace_listings" "AlmaLinux_Listings" {
  name           = ["AlmaLinux OS 9 (AArch64)"]
  compartment_id = local.compartment_id
}

data "oci_core_app_catalog_listing" "AlmaLinux_App_Catalog_Listing" {
  listing_id = data.oci_marketplace_listing_package.AlmaLinux_Listing_Package.app_catalog_listing_id
}

data "oci_core_app_catalog_listing_resource_versions" "AlmaLinux_App_Catalog_Listing_Resource_Versions" {
  listing_id = data.oci_marketplace_listing_package.AlmaLinux_Listing_Package.app_catalog_listing_id
}

data "oci_core_app_catalog_listing_resource_version" "AlmaLinux_App_Catalog_Listing_Resource_Version" {
  listing_id       = data.oci_marketplace_listing_package.AlmaLinux_Listing_Package.app_catalog_listing_id
  resource_version = data.oci_core_app_catalog_listing_resource_versions.AlmaLinux_App_Catalog_Listing_Resource_Versions.app_catalog_listing_resource_versions[0].listing_resource_version
}

resource "oci_core_app_catalog_listing_resource_version_agreement" "AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement" {
  listing_id               = data.oci_marketplace_listing_package.AlmaLinux_Listing_Package.app_catalog_listing_id
  listing_resource_version = data.oci_core_app_catalog_listing_resource_versions.AlmaLinux_App_Catalog_Listing_Resource_Versions.app_catalog_listing_resource_versions[0].listing_resource_version
}

resource "oci_core_app_catalog_subscription" "AlmaLinux_App_Catalog_Subscription" {
  compartment_id           = local.compartment_id
  eula_link                = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.eula_link
  listing_id               = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.listing_id
  listing_resource_version = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.listing_resource_version
  oracle_terms_of_use_link = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.oracle_terms_of_use_link
  signature                = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.signature
  time_retrieved           = oci_core_app_catalog_listing_resource_version_agreement.AlmaLinux_App_Catalog_Listing_Resource_Version_Agreement.time_retrieved
}