# UX Review Guidelines

Start with the human task: what does this person know, what are they trying to accomplish, and what must they understand or decide next? Review the changed user journey, not just individual widgets. Admin tools deserve the same clarity as customer screens. Apply these checks proportionately; they are not a reason to redesign unrelated pages.

1. **Task and hierarchy:** State who the screen serves and what they came to do. Make the next useful action obvious. Group related controls; keep secondary diagnostics out of the primary task flow.
2. **Familiar controls:** Reuse existing navigation, components and behavior. Use a leading Back arrow to return to the previous view and a trailing × in a panel header to dismiss that panel. Keep each icon reachable at narrow widths and give it a tooltip and accessible name describing its destination or scope. Use a select for a known set of choices instead of requiring users to remember and type values.
3. **Context and effort:** Carry known project/document/page context from the entry point. Avoid asking users to reselect it or perform redundant loading steps. Show the active scope clearly. In file trees, reveal a newly selected file once and preserve the scroll position when users expand other folders.
4. **Space and polish:** Give the working content adequate space. Remove redundant headings and stacked toolbars; use consistent spacing, typography and action emphasis. Compact does not mean tiny controls or unreadable text. Apply [Typography and Readability](#typography-and-readability).
5. **Truthful interaction:** Check that navigation changes displayed content, selection matches subsequent actions, and loading/error/empty/success states explain what happened and what to do next. Distinguish destructive actions clearly.
6. **Rendered verification:** Walk the main task on the actual screen at relevant desktop and narrow widths. Check keyboard operation, focus, labels and contrast. Capture evidence; source inspection and mocked component tests do not establish visual or usability acceptance.

## Typography and Readability

Type is the primary way an interface shows what matters. A reader should be able to tell, at a glance and without reading every word, which text is the item, which is the content, and which is metadata or an action. Achieve this with the project's existing type scale and color roles — not with new fonts, libraries or one-off sizes.

1. **Use the existing system; add no libraries.** Take every text style from the project's theme (for example `MaterialTheme.typography` roles plus the project's own text-style and color tokens). Do not add font, typography or UI-kit dependencies, and do not hard-code sizes, weights or colors in components. If a needed role is genuinely missing, add one named token to the existing scale and use it everywhere that information appears.
2. **A few roles, each with one meaning.** Map information types to roles and keep the mapping consistent across screens: *title* for the thing being shown (screen, card, item name), *body* for content people read, *label* for buttons, tabs, chips and compact metadata. A screen normally needs three or four roles. The same kind of information (every timestamp, every author, every status) always uses the same role and color.
3. **Hierarchy through size, weight and emphasis together.** Separate levels by at least one clear step in the scale and, where useful, by weight (regular 400 for reading text; medium 500 for titles, labels and emphasis) and by color emphasis (primary text versus the theme's secondary/variant text color). Do not create hierarchy with extra typefaces, many near-identical sizes, underlines or bold paragraphs. Use one UI typeface, plus monospace only for code, identifiers and logs.
4. **Readable minimums.** Text people need to read is body size: about 14sp/px on desktop and 16 on mobile (Material 3 Body Medium 14/20, Body Large 16/24). Twelve is for secondary metadata, 11 only for short labels, and nothing smaller. Do not use label sizes for sentences, errors or explanations. Avoid light weights at small sizes.
5. **Line height and line length.** Body line height about 1.4–1.5× the font size (Material 3: 14/20, 16/24); tighter only for single-line labels and large headings. Keep running text to roughly 40–75 characters per line by constraining the text width rather than shrinking type; long log or code lines may scroll or wrap explicitly.
6. **Contrast is a requirement, not a style.** Meet WCAG 2.2 AA: at least 4.5:1 for normal text and 3:1 for large text (18pt / 24px, or 14pt / ~18.7px bold) and for essential icons and control boundaries. Secondary text uses the theme's dedicated secondary color role and must still meet 4.5:1 in light and dark themes; never lower emphasis with arbitrary alpha that drops below it. Do not convey status by color alone — pair it with a word or icon.
7. **Case and wording.** Use sentence case for titles, buttons, menu items and labels. Reserve ALL CAPS for very short labels, if at all; never for sentences. Prefer a precise word over decorative styling ("Failed", "Deploying", "by alice" reads faster than a colored chip alone).
8. **Numbers, times and identifiers.** Use tabular (fixed-width) figures for values that update or align — timers, durations, counts, columns of numbers — so text does not jitter; most UI toolkits expose this as the OpenType `tnum` feature on the existing font. Show hashes, versions and paths in monospace and truncate them deliberately (keep the distinguishing part, such as a file name's end or a hash's first seven characters).
9. **Truncate secondary text only.** Primary text (the item name, the error, the decision a person must make) wraps rather than truncates. When secondary text must truncate, end with an ellipsis and make the full value available by tooltip, expansion or copy.
10. **Group with spacing, not more styles.** Keep related lines closer together than unrelated groups, on the project's 4/8 spacing grid. A metadata line belongs visually to its title; separate items by a larger gap or a divider rather than by a new text style.
11. **Verify the rendered result.** Review text at real size in light and dark themes, at desktop and narrow widths, and with the operating system's larger text setting. Check that the hierarchy survives a squint test: the most important text should still stand out when the screen is blurred.

## Review from the Human's Perspective

For each meaningful step, ask: does the person understand what to accomplish, notice the relevant control, predict its result from the label, and recognize progress afterward? Record the specific point of confusion and its consequence. An expert walkthrough is useful evidence, but does not replace observing actual users.

- **Reduce mental effort, not just clicks.** Do not make people memorize identifiers, infer hidden prerequisites, repeatedly enter known context or translate internal terminology. Prefer recognizable choices and persistent labels over placeholder-only instructions.
- **Reveal complexity when it becomes relevant.** Keep common actions discoverable; disclose optional diagnostics and advanced controls on demand. Put occasional row actions such as Copy path in the context menu. Give the selected search result a visible Reveal action when users need to locate it in a tree. Do not hide necessary steps merely to make the screen look cleaner or impose arbitrary limits on option counts.
- **Respect control and recovery.** Explain action scope and consequences, retain relevant input after an error, and offer a clear recovery or exit. Avoid silent success, unexplained disabled controls and technical error dumps.
- **Observe rather than coach.** Give someone a realistic task without explaining the intended clicks. Note hesitation, wrong turns, success and recovery; address those observations before cosmetic preferences. Test the existing supported journey, not hypothetical new features.

## References

These human-centered review rules draw on Google's design-review guidance. They do not prescribe a visual framework or claim Google approval:

- [Apple Human Interface Guidelines on toolbar navigation and placement](https://developer.apple.com/design/human-interface-guidelines/toolbars)
- [Google Design: Design Reviews — Going Beyond the Surface](https://design.google/library/reviewing-the-design-review): review the problem, information hierarchy, familiar patterns and the implemented experience.

- [NN/G: Cognitive walkthroughs](https://www.nngroup.com/articles/cognitive-walkthroughs/): evaluate whether a newcomer can discover and understand each task step; distinguish inspection from user testing.
- [NN/G: Recognition and recall](https://www.nngroup.com/articles/recognition-and-recall/): provide visible choices and contextual cues instead of requiring memorization.
- [NN/G: Reducing cognitive load in forms](https://www.nngroup.com/articles/4-principles-reduce-cognitive-load/): structure, transparency, clarity and support.
- [NN/G: Progressive disclosure](https://www.nngroup.com/articles/progressive-disclosure/): defer advanced options while keeping common tasks accessible.
- [NN/G: Usability heuristics](https://www.nngroup.com/articles/ten-usability-heuristics/): system feedback, user control, consistency, error prevention and recovery.

Typography rules follow Material Design's type system and the WCAG contrast requirements:

- [Material 3: Typography overview](https://m3.material.io/styles/typography/overview), [applying type](https://m3.material.io/styles/typography/applying-type) and [type scale tokens](https://m3.material.io/styles/typography/type-scale-tokens): a small set of display, headline, title, body and label roles with defined size, line height and weight.
- [Google Design: Typography](https://design.google/tags/typography): Google's essays on readability, type grade for light and dark modes, superfamilies and screen-first typefaces.
- [WCAG 2.2: Contrast (Minimum)](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html): 4.5:1 for normal text and 3:1 for large text.
- [UX Collective: 10 key takeaways from Google's Material Design guidelines](https://uxdesign.cc/10-key-takeaways-from-googles-material-design-guidelines-3b0867f0465a) (member-only): signifiers, hierarchy and consistency drawn from Material.
