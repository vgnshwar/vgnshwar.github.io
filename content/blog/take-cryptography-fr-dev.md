+++
date = "2026-06-14"
title = 'Take Cryptography Away From Developers'
tags = ["security",]
+++

<b>TL;DR:</b> We need to stop letting developers hard-code specific security algorithms into their main applications. By shifting to an "intent-based" API design, developers simply ask to encrypt data, and security engineers control the actual math in the background, making enterprise systems instantly upgradeable and quantum-proof without rewriting any code.

Lately, as I’ve been looking at how we build and secure modern enterprise systems, I’ve noticed a glaring structural flaw in our process. We talk endlessly about preparing for the post-quantum era, but we are completely missing the point. When that day comes, we are going to face a massive crisis, but not just because of the complex math behind the algorithms. The real nightmare is purely a software engineering and project management problem.

## The Current Nightmare: Tight Coupling

Right now, if you are a developer building a login page, you usually research the best security solution and build it directly into your repository. You write a line of code that explicitly calls for a specific algorithm, like AES-256.

This gives the developer total ownership, but it is actually a terrible setup. Why? Because you just glued the application code directly to the math.

If a new, secure algorithm needs to be updated across an enterprise, the security engineers cannot just fix it. They have to raise tickets, wait for developers to update the security changes in the main repo, test it, and deploy it. It requires tracking down thousands of hard-coded algorithm names across countless projects. It is slow, painful, and places an unfair burden on developers who shouldn't have to be cryptography experts just to build a solid app.

## The Core Idea: Shifting Ownership

We need to separate the work process. We must reduce the burden on developers and give security engineers full, centralized control over the cryptography.

To do this, we have to hide the algorithm names from the main codebase entirely. Instead of asking for an algorithm, the application should only ask for a <b>"scope"</b> or an intent.

The developer only needs to know the basic outcome they want, like "Standard Signature" or "Password Hashing." They write a simple object call using a plain text nickname for the key. They never see or touch the actual complex math formula.

## How It Works Practically

We put a smart 'Policy Engine' between the main code and the math.

When a developer writes their code, they simply pass the data and the key's nickname to the API. Behind the scenes, the system checks the central policy managed by the security engineers. The policy looks at the developer's requested scope and automatically assigns the safest, most current algorithm to do the job.

The magic here relies on keeping inputs consistent. Scopes are strictly grouped by the inputs they require. If one signature algorithm only needs a plain document, and a newer one requires the document plus a context tag, they are put into different scopes. This guarantees that when the security team upgrades the algorithm in the background, the new math perfectly matches the inputs the main code is already sending. The app never crashes.

## Why It Matters

This setup completely changes how a company survives the post-quantum transition.

If a quantum computing threat emerges tomorrow, or if an old algorithm is suddenly compromised, the enterprise does not panic. The security team simply updates their central policy repo to point to a new, secure algorithm. Instantly, the change applies across the entire company.

No developer has to wait. No one makes an unresearched, wrong decision. No one rewrites a single line of application code. Even if our scope names leak, the user's data remains protected because the actual algorithms are isolated and managed by the experts.

By separating the responsibilities and using intent-based access, we give developers their speed back and give security engineers the ultimate freedom to protect the system.

<I>Reference: This thought process was heavily inspired by the core concepts detailed in "Intent-Based Cryptographic API Design for Cryptographic Agility" by Navaneeth Rameshan and Gregoire Messmer.</I>