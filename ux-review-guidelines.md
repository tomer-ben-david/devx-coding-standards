# UX Review Guidelines

Start with the human task: what does this person know, what are they trying to accomplish, and what must they understand or decide next? Review the changed user journey, not just individual widgets. Admin tools deserve the same clarity as customer screens. Apply these checks proportionately; they are not a reason to redesign unrelated pages.

1. **Task and hierarchy:** State who the screen serves and what they came to do. Make the next useful action obvious. Group related controls; keep secondary diagnostics out of the primary task flow.
2. **Familiar controls:** Reuse existing navigation, components and behavior. Offer previous/next and return navigation where users expect them. Use a select for a known set of choices instead of requiring users to remember and type values.
3. **Context and effort:** Carry known project/document/page context from the entry point. Avoid asking users to reselect it or perform redundant loading steps. Show the active scope clearly.
4. **Space and polish:** Give the working content adequate space. Remove redundant headings and stacked toolbars; use consistent spacing, typography and action emphasis. Compact does not mean tiny controls or unreadable text.
5. **Truthful interaction:** Check that navigation changes displayed content, selection matches subsequent actions, and loading/error/empty/success states explain what happened and what to do next. Distinguish destructive actions clearly.
6. **Rendered verification:** Walk the main task on the actual screen at relevant desktop and narrow widths. Check keyboard operation, focus, labels and contrast. Capture evidence; source inspection and mocked component tests do not establish visual or usability acceptance.

## Review from the Human's Perspective

For each meaningful step, ask: does the person understand what to accomplish, notice the relevant control, predict its result from the label, and recognize progress afterward? Record the specific point of confusion and its consequence. An expert walkthrough is useful evidence, but does not replace observing actual users.

- **Reduce mental effort, not just clicks.** Do not make people memorize identifiers, infer hidden prerequisites, repeatedly enter known context or translate internal terminology. Prefer recognizable choices and persistent labels over placeholder-only instructions.
- **Reveal complexity when it becomes relevant.** Keep common actions discoverable; disclose optional diagnostics and advanced controls on demand. Do not hide necessary steps merely to make the screen look cleaner or impose arbitrary limits on option counts.
- **Respect control and recovery.** Explain action scope and consequences, retain relevant input after an error, and offer a clear recovery or exit. Avoid silent success, unexplained disabled controls and technical error dumps.
- **Observe rather than coach.** Give someone a realistic task without explaining the intended clicks. Note hesitation, wrong turns, success and recovery; address those observations before cosmetic preferences. Test the existing supported journey, not hypothetical new features.

## References

These human-centered review rules draw on Google's design-review guidance. They do not prescribe a visual framework or claim Google approval:

- [Google Design: Design Reviews — Going Beyond the Surface](https://design.google/library/reviewing-the-design-review): review the problem, information hierarchy, familiar patterns and the implemented experience.

- [NN/G: Cognitive walkthroughs](https://www.nngroup.com/articles/cognitive-walkthroughs/): evaluate whether a newcomer can discover and understand each task step; distinguish inspection from user testing.
- [NN/G: Recognition and recall](https://www.nngroup.com/articles/recognition-and-recall/): provide visible choices and contextual cues instead of requiring memorization.
- [NN/G: Reducing cognitive load in forms](https://www.nngroup.com/articles/4-principles-reduce-cognitive-load/): structure, transparency, clarity and support.
- [NN/G: Progressive disclosure](https://www.nngroup.com/articles/progressive-disclosure/): defer advanced options while keeping common tasks accessible.
- [NN/G: Usability heuristics](https://www.nngroup.com/articles/ten-usability-heuristics/): system feedback, user control, consistency, error prevention and recovery.

