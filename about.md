---
layout: page
title: "About us"
subtitle: "Who we are, how we vet partners, and how to check our work."
permalink: /about/
description: "Lifeline for Ukraine Inc. is a 501(c)(3) non-profit in West Hartford, Connecticut providing critical medical supplies to communities impacted by the Russian-Ukrainian war."
---

{%- include donate-state.html -%}

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

It also means we buy real equipment. Counterfeit tourniquets are widespread in this war —
they are cheap, they look right, and they snap under load. The tourniquets we send are
genuine **CAT (Combat Application Tourniquet)** units, NSN 6515-01-521-7976, carrying the
American College of Surgeons mark. The blood-clotting gauze is **Celox Rapid**. We buy
**Rhino Rescue** vented chest seals and **MedResQ** Israeli-type bandages, which are budget
brands rather than premium ones — a deliberate trade, because for bandages and seals the
volume matters more than the label, while for a tourniquet it does not.

## What we do not buy

Donated money buys medical supplies. It does not buy vehicles, drones, uniforms, optics, or
anything else, however often we are asked. It is a narrow remit and we keep it deliberately:
it is the only way an organization this small can be certain of what it is doing, and it is
what lets us say that every donated dollar goes to medical aid and mean it exactly.

## The ledger

Core medical supplies bought and sent as of {{ site.data.impact.as_of }} — the whole
category, not the impressive parts of it. Cold-weather items and the contents of any
individual package are on the [shipments page]({{ '/shipments/' | relative_url }}).

<div class="ledger__wrap" markdown="0">
<table class="ledger" id="ledger">
  <caption>
    Core medical supplies since 2022. Approximate counts are marked with a tilde.
    Hand and toe warmers are counted per shipment rather than here.
  </caption>
  <thead>
    <tr><th scope="col">Item</th><th scope="col">Total</th><th scope="col">Notes</th></tr>
  </thead>
  <tbody>
  {%- for row in site.data.supplies %}
    <tr>
      <td>{{ row.item }}</td>
      <td>{{ row.total }}</td>
      <td>{% if row.note %}{{ row.note }}{% endif %}</td>
    </tr>
  {%- endfor %}
  </tbody>
</table>
</div>

The refund line is there on purpose. In December 2023 an order of 15 tourniquets from one
supplier was refunded rather than delivered, so those 15 are not counted in the total above.
We would rather publish the number that is true than the number that is larger.

## Transparency

**100% of your donations are spent on medical aid for Ukraine.** No salaries, no overhead,
no administrative cut.

{% if card_ready and card_provider == "zeffy" %}We picked our payment methods so that stays
true end to end. Zelle moves money bank to bank at no cost, and Zeffy charges non-profits no
platform fee and no processing fee — it stays free by asking donors whether they want to add
an optional contribution to Zeffy, separate from their gift to us. A $35 donation reaches us
as $35.{% elsif card_ready and card_provider == "paypal" %}One caveat, stated plainly: card
donations pass through PayPal, which deducts its charity rate of 1.99% plus $0.49 before the
money reaches us. Zelle and checks arrive whole.{% else %}Both ways to give on this site —
Zelle and a mailed check — move money at no cost. Nothing is deducted before it reaches
us.{% endif %}

Verify our tax-exempt status through the
[IRS Tax Exempt Organization Search](https://apps.irs.gov/app/eos/) using EIN
{{ site.org.ein }}. Our [updates]({{ '/updates/' | relative_url }}) page is the running record
of what donations actually bought.

## Who runs this

Lifeline for Ukraine was founded by **Liana Pshevorska**, who is its president. It is run by
volunteers; nobody is paid.

> I have learned that some soldiers, equipped with the medical kits and tourniquets provided
> through your support, were able to survive long enough to be evacuated from the battlefield
> and reach hospitals. Some of my IFAK medical kits were rushed to the site of a missile
> attack in the center of Sumy — northern Ukraine, on the Russian border — and were used to
> help save civilian lives as well.
>
> <cite>Liana Pshevorska, founder and president</cite>

{% comment %}
TODO: link the most recent Form 990 once it has been filed. Board members are not
listed yet — add them here alongside Liana once they have agreed to be named.
{% endcomment %}

## Contact

**{{ site.org.legal_name }}**
{{ site.org.street }}
{{ site.org.city }}, {{ site.org.state }} {{ site.org.zip }}
{{ site.org.country }}

Phone: [{{ site.org.phone }}](tel:{{ site.org.phone_link }})
{% if site.org.email and site.org.email != "" %}Email: [{{ site.org.email }}](mailto:{{ site.org.email }}){% endif %}

EIN: **{{ site.org.ein }}**
