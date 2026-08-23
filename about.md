---
layout: page
title: "About us"
subtitle: "Who we are, how we vet partners, and how to check our work."
permalink: /about/
description: "Lifeline for Ukraine Inc. is a 501(c)(3) non-profit in West Hartford, Connecticut providing critical medical supplies to communities impacted by the Russian-Ukrainian war."
---

## Our mission

Lifeline for Ukraine Inc. provides critical medical supplies to communities impacted by the
Russian-Ukrainian war.

## How we started

Lifeline for Ukraine Inc. is a 501(c)(3) tax-exempt non-profit organization based in West
Hartford, Connecticut (EIN {{ site.org.ein }}). Its creation was prompted by Russia's
full-scale invasion of Ukraine in 2022.

We work with trusted partners in Ukraine to deliver the essential medical supplies needed to
protect the lives of Ukrainians facing Russian aggression. We focus on critical items such as
Individual First Aid Kits (IFAKs), tourniquets, and blood-clotting gauze — the things that
decide whether an injury is survivable.

## How we decide what to buy

We are connected to local doctors and servicemen who communicate their most urgent medical
needs directly to us. That is the whole procurement process: someone who is about to run out
of tourniquets tells us, and we buy tourniquets.

It also means we buy real equipment from vetted suppliers. Counterfeit tourniquets are
widespread in this war and they fail under load, so the sourcing matters as much as the
funding.

## Transparency

**100% of your donations are spent on medical aid for Ukraine.** No salaries, no overhead,
no administrative cut. We believe in full financial transparency and are accountable to our
donors.

{% if site.donate.provider == "zeffy" %}That claim survives contact with the payment
processors, because we picked ours for exactly that reason. Zelle moves money bank to bank at
no cost. Zeffy, which handles card donations, charges non-profits no platform fee and no
processing fee — it stays free by asking donors whether they would like to add an optional
contribution to Zeffy, separate from their gift to us. A card donation of $35 reaches us as
$35.{% elsif site.donate.provider == "paypal" %}One honest caveat: card and PayPal donations
pass through PayPal, which deducts its charity rate of 1.99% plus $0.49 before the money
reaches us. Giving by Zelle or by check avoids that entirely — those arrive
whole.{% else %}Both of the ways to give on this site — Zelle and a mailed check — move money
at no cost, so nothing is deducted before it reaches us.{% endif %}

You can verify our tax-exempt status through the
[IRS Tax Exempt Organization Search](https://apps.irs.gov/app/eos/) using our EIN,
{{ site.org.ein }}. Our [updates]({{ '/updates/' | relative_url }}) page is the running
record of what your donations actually bought.

{% comment %}
TODO before launch: add the team/board section, and link the most recent Form 990
once it has been filed.
{% endcomment %}

## Contact

**{{ site.org.legal_name }}**
{{ site.org.street }}
{{ site.org.city }}, {{ site.org.state }} {{ site.org.zip }}
{{ site.org.country }}

Phone: [{{ site.org.phone }}](tel:{{ site.org.phone_link }})
{% if site.org.email and site.org.email != "" %}Email: [{{ site.org.email }}](mailto:{{ site.org.email }}){% endif %}

EIN: **{{ site.org.ein }}**
